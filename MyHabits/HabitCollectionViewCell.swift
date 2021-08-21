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
        label.text = "Test1"
        label.textColor = UIColor(rgb: 0x296DFF)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    let subtitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в 7:30"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let counterLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Счетчик: 0"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let statusImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.orange.cgColor
        image.layer.cornerRadius = 36 / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
//    let areaView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 8
//        view.backgroundColor = .white
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension HabitCollectionViewCell {
//    func setupViews() {
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(areaView)
//
//        areaView.addSubview(titleLable)
//        areaView.addSubview(subtitleLable)
//        areaView.addSubview(counterLable)
//        areaView.addSubview(statusImageView)
//
//        let constraints = [
//
//            areaView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            areaView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
//            areaView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            areaView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            areaView.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width) - 32),
//            areaView.heightAnchor.constraint(equalToConstant: 130),
//
//            titleLable.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 20),
//            titleLable.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 20),
//
//            subtitleLable.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 20),
//            subtitleLable.topAnchor.constraint(equalTo: titleLable.topAnchor, constant: 4),
//
//            counterLable.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 20),
//            counterLable.bottomAnchor.constraint(equalTo: areaView.bottomAnchor, constant: -20),
//
//            statusImageView.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 46),
//            statusImageView.trailingAnchor.constraint(equalTo: areaView.trailingAnchor, constant: -46),
//            statusImageView.bottomAnchor.constraint(equalTo: areaView.bottomAnchor, constant: -46),
//
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//}

extension HabitCollectionViewCell {
    func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLable)
        contentView.addSubview(subtitleLable)
        contentView.addSubview(counterLable)
        contentView.addSubview(statusImageView)
        
        let constraints = [
            
            contentView.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width - 32)),
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLable.heightAnchor.constraint(equalToConstant: 22),
            
            subtitleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
            subtitleLable.heightAnchor.constraint(equalToConstant: 16),
            
            counterLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLable.topAnchor.constraint(equalTo: subtitleLable.bottomAnchor, constant: 30),
            counterLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            counterLable.heightAnchor.constraint(equalToConstant: 18),

            statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            statusImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            statusImageView.widthAnchor.constraint(equalToConstant: 36),
            statusImageView.heightAnchor.constraint(equalToConstant: 36),

        ]
        NSLayoutConstraint.activate(constraints)
    }
}
