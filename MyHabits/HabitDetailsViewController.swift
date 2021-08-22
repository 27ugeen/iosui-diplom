//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 8/22/21.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = String(describing: HabitDetailsTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(rgb: 0xF2F2F7)
        
        setupTableView()
        setupConstraints()
    }
}

extension HabitDetailsViewController {
    func setupTableView() {
        let buttonEdit = UIBarButtonItem(title: "Править", style: .done, target: self, action: nil)
        buttonEdit.tintColor = UIColor(rgb: 0xA116CC)
        
        self.navigationItem.setRightBarButtonItems([buttonEdit], animated: true)
        
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
        cell.dateLabel.text = String(describing: HabitsStore.shared.dates)
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

