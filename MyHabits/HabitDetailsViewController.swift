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
    
//    weak var indexPathDelegate: IndexPathDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupConstraints()
    }
}

extension HabitDetailsViewController {
    func setupTableView() {
        view.backgroundColor = UIColor(rgb: 0xF2F2F7)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: cellID)
        
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
        return HabitsStore.shared.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HabitDetailsTableViewCell
        
        guard let dateString = store.trackDateString(forIndex: indexPath.row) else {
            return cell
        }
        cell.dateLabel.text = dateString
        
//        let idx = indexPathDelegate?.sendIndexPath(sender: editButton)
//        print(idx!)
        
//        if store.habit(currentHabit, isTrackedIn: currentDate) {
//            cell.accessoryType = .checkmark
//            cell.tintColor = buttonColor
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cell = HabitDetailsTableViewCell()
        
        return cell.habitDetailsTitleLabel.text
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

