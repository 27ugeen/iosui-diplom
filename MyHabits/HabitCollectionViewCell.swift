//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by GiN Eugene on 20.08.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let percentLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50%"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let progressLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(rgb: 0xD8D8D8)
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HabitCollectionViewCell {
    func setupViews() {
        contentView.addSubview(titleLable)
        contentView.addSubview(percentLable)
        contentView.addSubview(progressLable)
        
        let constraints = [
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
//            percentLable.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor, constant: 8),
            percentLable.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            percentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//            percentLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            progressLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            progressLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
