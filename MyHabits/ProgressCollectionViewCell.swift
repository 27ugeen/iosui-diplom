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
    
    let progressImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(rgb: 0xD8D8D8)
        image.layer.cornerRadius = 5
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

//extension ProgressCollectionViewCell {
//    func setupViews() {
//        contentView.translatesAutoresizingMaskIntoConstraints = false
////        let cellWidth = UIScreen.main.bounds.width - 32
//
//        contentView.addSubview(areaView)
//
//        areaView.addSubview(titleLable)
//        areaView.addSubview(percentLable)
//        areaView.addSubview(progressImageView)
//
//        let constraints = [
//
//            areaView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            areaView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
//            areaView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            areaView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            areaView.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width) - 32),
//            areaView.heightAnchor.constraint(equalToConstant: 60),
//
//            titleLable.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 12),
//            titleLable.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 10),
//
//            percentLable.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 10),
//            percentLable.trailingAnchor.constraint(equalTo: areaView.trailingAnchor, constant: -12),
//
//            progressImageView.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 12),
//            progressImageView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
//            progressImageView.trailingAnchor.constraint(equalTo: areaView.trailingAnchor, constant: -12),
//            progressImageView.bottomAnchor.constraint(equalTo: areaView.bottomAnchor, constant: -15),
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//}

extension ProgressCollectionViewCell {
    func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8

        contentView.addSubview(titleLable)
        contentView.addSubview(percentLable)
        contentView.addSubview(progressImageView)
        
        let constraints = [
            
            contentView.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width - 32)),
            
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLable.heightAnchor.constraint(equalToConstant: 18),


            percentLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentLable.heightAnchor.constraint(equalToConstant: 18),

            progressImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressImageView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            progressImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressImageView.heightAnchor.constraint(equalToConstant: 7),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
