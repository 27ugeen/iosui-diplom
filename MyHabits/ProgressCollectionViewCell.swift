//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by GiN Eugene on 20.08.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let percentLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50%"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let progressLable: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(rgb: 0xD8D8D8)
        //        label.text = "============================="
        //        label.backgroundColor = .black
        label.layer.cornerRadius = 5
//        label.numberOfLines = 0
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

extension ProgressCollectionViewCell {
    func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        
        
        contentView.addSubview(titleLable)
        contentView.addSubview(percentLable)
        contentView.addSubview(progressLable)
        
        let constraints = [
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
//                        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 343),
            contentView.heightAnchor.constraint(equalToConstant: 60),
            
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            //            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            //            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //            percentLable.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor, constant: 8),
            percentLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentLable.heightAnchor.constraint(equalTo: titleLable.heightAnchor),
            //            percentLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            progressLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            progressLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//            progressLable.widthAnchor.constraint(greaterThanOrEqualToConstant: 319),
            //            percentLable.heightAnchor.constraint(equalToConstant: 7),
            
            progressLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}