//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 19.08.2021.
//

import UIKit

//protocol IndexPathDelegate: AnyObject {
//    func sendIndexPath(sender: UIBarButtonItem, indexPath: Int)
//}

class HabitsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(rgb: 0xF2F2F7)
        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Сегодня"
        self.tabBarItem.title = "Привычки"
        
        setupView()
        setupConstraints()
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let habitDetailsVC = segue.destination as? HabitDetailsViewController {
//            habitDetailsVC.indexPathDelegate? = self
//        }
//    }
}
////====================================================
//extension HabitsViewController: IndexPathDelegate {
//    func sendIndexPath(sender: UIBarButtonItem, indexPath) {
//        let indexPathItem = sender.tag
//        print("MainVC \(indexPathItem)")
//}
////====================================================
extension HabitsViewController {
    func setupView() {
        view.backgroundColor = UIColor(rgb: 0xFFFFFF)
        
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addHabit))
        buttonAdd.tintColor = UIColor(rgb: 0xA116CC)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.title = "Сегодня"
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.setRightBarButtonItems([buttonAdd], animated: true)
    }
    
    @objc
    private func addHabit() {
        let habitVC = HabitViewController()
        habitVC.title = "Создать"
        let habitNavVC = UINavigationController(rootViewController: habitVC)
        habitNavVC.modalPresentationStyle = .fullScreen
        habitNavVC.modalTransitionStyle = .coverVertical
        self.present(habitNavVC, animated: true, completion: nil)
    }
    
    @objc
    private func editHabit(sender: UIBarButtonItem) {
        let indexPathItem = sender.tag

        let habitVC = HabitViewController()
        habitVC.title = "Править"
        
        let habitIndexPath = store.habits[indexPathItem]

        habitVC.addHabitTextField.text = habitIndexPath.name
        habitVC.colorHabitView.backgroundColor = habitIndexPath.color
        habitVC.timeSubtitleHabitLabel.text = habitIndexPath.dateString
        
        let habitNavVC = UINavigationController(rootViewController: habitVC)
        habitNavVC.modalPresentationStyle = .fullScreen
        habitNavVC.modalTransitionStyle = .coverVertical
        self.present(habitNavVC, animated: true, completion: nil)
    }
    
    @objc
    func circleTapped(sender: UIButton){
        let buttonIndex = sender.tag
        
        let progressView = ProgressCollectionViewCell()
        
        
        let currentHabit = store.habits[buttonIndex]
        if !currentHabit.isAlreadyTakenToday {
            store.track(currentHabit)
            progressView.progressImageView.progress = store.todayProgress
            collectionView.reloadData()
        } else {
            print("habit is already tracked!")
        }
        print(currentHabit.isAlreadyTakenToday)
    }
}

extension HabitsViewController {
    func setupConstraints() {
        
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section == 0 else {
            print("Habits count: \(store.habits.count)")
            return store.habits.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.section == 0 else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            
            cell.titleLable.text = store.habits[indexPath.item].name
            cell.subtitleLable.text = store.habits[indexPath.item].dateString
            cell.statusButton.tintColor = store.habits[indexPath.item].color
//            cell.tag = indexPath.item
            
            cell.statusButton.tag = indexPath.item
            cell.statusButton.addTarget(self, action: #selector(circleTapped), for: .touchUpInside)
            
            if store.habits[indexPath.item].isAlreadyTakenToday {
                cell.statusButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                cell.statusButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        
        let store = HabitsStore.shared
        cell.percentLable.text = "\(String(describing: Int(store.todayProgress * 100)))%"
    
//        let habitsCount = store.habits.count
//
//        let progressTotal = store.habits.count
        
        cell.progressImageView.setProgress( 0, animated: false)
        
        cell.progressImageView.progress = store.todayProgress
        cell.progressImageView.progressTintColor = buttonColor
        
        return cell
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPathItem: \(indexPath.item)")

        let indexPathItem = (indexPath.section, indexPath.row)
        
        if indexPathItem != (0, 0) {
            let habitDetailsVC = HabitDetailsViewController()
            let buttonEdit = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editHabit))
            buttonEdit.tag = indexPath.item
            habitDetailsVC.navigationItem.setRightBarButtonItems([buttonEdit], animated: true)
            habitDetailsVC.title = store.habits[indexPath.item].name
            
//            let habitDetailsTableViewCell = HabitDetailsTableViewCell()
//
//            let currentHabit = store.habits[indexPath.item]
//            let date = store.habits[indexPath.item].date
//            let isTrackedINDate = habitDetailsVC.store.habit(currentHabit, isTrackedIn: date)
//
//            habitDetailsTableViewCell.accessoryType = .checkmark
            self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0xA116CC)
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 16 * 2)
        let cellHeight: CGFloat
        
        indexPath.section == 0 ? (cellHeight = 60) : (cellHeight = 130)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard section == 0 else {
            return UIEdgeInsets(top: 18, left: 16, bottom: 0, right: 16)
        }
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
    }
}

