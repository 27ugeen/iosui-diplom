//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 19.08.2021.
//

import UIKit

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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("willAppear")
//        self.navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.forceUpdateNavBar()
        
        collectionView.reloadData()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//    }
}

extension HabitsViewController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0xFFFFFF)
        
        self.navigationItem.title = "Сегодня"
        self.tabBarItem.title = "Привычки"
        
        
        
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addHabit))
        buttonAdd.tintColor = buttonColor
        
        self.navigationItem.setRightBarButtonItems([buttonAdd], animated: true)
        
        collectionView.reloadData()
    }
    
    @objc private func addHabit() {
        let habitVC = HabitViewController(habit: Habit.init(name: "", date: Date(), color: .systemOrange))
        
        habitVC.title = "Создать"
        let habitNavVC = UINavigationController(rootViewController: habitVC)
        habitNavVC.modalPresentationStyle = .fullScreen
        self.present(habitNavVC, animated: true, completion: nil)
    }
    
    @objc func circleTapped(sender: UIButton){
        let buttonIndex = sender.tag
        
        let progressView = ProgressCollectionViewCell()
        
        let currentHabit = store.habits[buttonIndex]
        if !currentHabit.isAlreadyTakenToday {
            store.track(currentHabit)
            progressView.progressImageView.progress = store.todayProgress
            collectionView.reloadData()
        } else {
            print("habit is already tracked!")
            let alert = UIAlertController(title: "Внимание!", message: "Привычка \(currentHabit.name) сегодня уже выполнена!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        print("Current habit \(currentHabit.name) isAlreadyTakenToday: \(currentHabit.isAlreadyTakenToday)")
    }
}

extension HabitsViewController {
    func setupConstraints() {
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            let store = HabitsStore.shared
            cell.percentLable.text = "\(String(describing: Int(store.todayProgress * 100)))%"
            cell.progressImageView.setProgress( 0, animated: false)
            cell.progressImageView.progress = store.todayProgress
            cell.progressImageView.progressTintColor = buttonColor
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            
            cell.titleLable.text = store.habits[indexPath.item].name
            cell.subtitleLable.text = store.habits[indexPath.item].dateString
            cell.statusButton.tintColor = store.habits[indexPath.item].color
            cell.statusButton.tag = indexPath.item
            
            cell.counterNumber.text = String(describing: store.habits[indexPath.item].trackDates.count)
            cell.statusButton.addTarget(self, action: #selector(circleTapped), for: .touchUpInside)
            
            if store.habits[indexPath.item].isAlreadyTakenToday {
                cell.statusButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                cell.statusButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            }
            return cell
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPathItem: \(indexPath.item)")
        
        let indexPathItem = (indexPath.section, indexPath.row)
        
        if indexPathItem != (0, 0) {
            let habitDetailsVC = HabitDetailsViewController(habit: store.habits[indexPath.item])
            
            self.navigationController?.navigationBar.tintColor = buttonColor
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

extension UINavigationController {
    func forceUpdateNavBar() {
        DispatchQueue.main.async {
            self.navigationBar.sizeToFit()
        }
      }
}
