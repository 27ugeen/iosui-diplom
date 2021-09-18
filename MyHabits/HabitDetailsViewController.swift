//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 8/22/21.
//

import UIKit

import Foundation

class HabitDetailsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = String(describing: HabitDetailsTableViewCell.self)

    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        setupTableView()
        setupConstraints()
    }
    
    @objc private func editHabit() {
        let habitVC = HabitViewController()
        habitVC.title = "Править"

        habitVC.addHabitTextField.text = habit.name
        habitVC.colorHabitView.backgroundColor = habit.color
        habitVC.timeSubtitleHabitLabel.text = habit.dateString
        
        let habitNavVC = UINavigationController(rootViewController: habitVC)
        habitNavVC.modalPresentationStyle = .fullScreen
        habitNavVC.modalTransitionStyle = .coverVertical
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
        
        self.title = habit.name
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
        let sortedDates = store.dates.sorted { $0 > $1 }
        
        if let dateString = store.trackDateString(forIndex: indexPath.row) {
            cell.dateLabel.text = dateString
        }
        
        if store.habit(habit, isTrackedIn: sortedDates[indexPath.row]) {
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

