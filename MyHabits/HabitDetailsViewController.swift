//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 8/22/21.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = String(describing: HabitDetailsTableViewCell.self)
    
    var currentHabit: Habit
    
    init(habit: Habit) {
        self.currentHabit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationItem.largeTitleDisplayMode = .never
        
        if !store.habits.contains(currentHabit) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func editHabit() {
        let habitVC = HabitViewController(habit: currentHabit)
        habitVC.title = "Править"
        
        habitVC.addHabitTextField.text = currentHabit.name
        habitVC.colorHabitView.backgroundColor = currentHabit.color
        habitVC.timeHabitLabel.text = String(currentHabit.dateString.dropFirst(14))
        habitVC.setHabitTimeDatePicker.date = currentHabit.date
        
        let habitNavVC = UINavigationController(rootViewController: habitVC)
        habitNavVC.modalPresentationStyle = .fullScreen
        self.present(habitNavVC, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController {
    func setupTableView() {
        view.backgroundColor = UIColor(rgb: 0xF2F2F7)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: cellID)
        
        let buttonEdit = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editHabit))
        
        self.title = currentHabit.name
        self.navigationItem.setRightBarButtonItems([buttonEdit], animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HabitDetailsViewController {
    func setupConstraints() {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HabitDetailsTableViewCell
        
        if let dateString = store.trackDateString(forIndex: indexPath.row) {
            cell.dateLabel.text = dateString
        }
        
        let sortedDates = store.dates.sorted { $0 > $1 }
        if store.habit(currentHabit, isTrackedIn: sortedDates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = buttonColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cell = HabitDetailsTableViewCell()
        return cell.habitDetailsTitleLabel.text
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

