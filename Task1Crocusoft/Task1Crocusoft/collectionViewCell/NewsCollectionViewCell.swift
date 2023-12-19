//
//  NewsCollectionViewCell.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 28.10.23.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = .white
        label.numberOfLines = 4
        //label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.backgroundColor  = UIColor(red: 0.083, green: 0.083, blue: 0.083, alpha: 0.4).cgColor
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func setUpCollectionViewCellContent(index: Int) {
        backgroundView = UIImageView(image: UIImage(named: index == 1 ? "news2" : "news1"))
        titleLabel.text = index == 1 ? "Ağcabədinin Pərioğullar və Hacıbədəlli kəndlərinin elektrik şəbəkəsi yenidən qurulur. Ağcabədinin Pərioğullar və Hacıbədəlli kəndlərinin elektrik şəbəkəsi yenidən qurulur." : "Prezident İlham Əliyev Mingəçevir şəhərinin elektrik paylayıcı şəbəkəsinin Avtomatik İdarəetmə. Prezident İlham Əliyev Mingəçevir şəhərinin elektrik paylayıcı şəbəkəsinin Avtomatik İdarəetmə."
    }
}
