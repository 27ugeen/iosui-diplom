//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by GiN Eugene on 20.08.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    let subtitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = secondLabelTextColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let counterLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Счетчик: "
        label.textColor = mainLabelTextColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    var counterNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = mainLabelTextColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(circleTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func circleTapped() {
        if statusButton.currentBackgroundImage == UIImage(systemName: "circle") {
            statusButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            print("button is already tupped")
        }
    }
}

extension HabitCollectionViewCell {
    func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLable)
        contentView.addSubview(subtitleLable)
        contentView.addSubview(counterLable)
        contentView.addSubview(counterNumber)
        contentView.addSubview(statusButton)
        
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 130),
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -63),
            
            subtitleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
            
            counterLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            counterNumber.leadingAnchor.constraint(equalTo: counterLable.trailingAnchor),
            counterNumber.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            statusButton.widthAnchor.constraint(equalToConstant: 38),
            statusButton.heightAnchor.constraint(equalToConstant: 38),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
