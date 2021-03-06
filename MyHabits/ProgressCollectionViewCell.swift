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
        label.textColor = mainLabelTextColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let percentLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50%"
        label.textColor = mainLabelTextColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let progressImageView: UIProgressView = {
        let image = UIProgressView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(rgb: 0xD8D8D8)
        image.layer.cornerRadius = 5
        return image
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
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLable)
        contentView.addSubview(percentLable)
        contentView.addSubview(progressImageView)
        
        let constraints = [
            
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            percentLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressImageView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            progressImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressImageView.heightAnchor.constraint(equalToConstant: 7),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
