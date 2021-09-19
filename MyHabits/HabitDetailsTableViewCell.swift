//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by GiN Eugene on 8/22/21.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    var habitDetailsTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "АКТИВНОСТЬ"
        title.textColor = UIColor(rgb: 0x3C3C4399).withAlphaComponent(0.6)
        title.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        title.numberOfLines = 0
        return title
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HabitDetailsTableViewCell {
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.backgroundColor = .white
        
        let constraints = [
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
