//
//  FirstCollectionViewCell.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 28.10.23.
//

import UIKit

class EnergyCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .appWhite5
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setUpEnergyCollectionViewCellContent(index: Int) {
        switch index {
        case 0:
            contentView.backgroundColor = .energyCollectionViewBlue
            titleLabel.text = "Ortalama Enerji\nİstehlakı"
            imageView.image = UIImage(named: "average-energy")
        case 1:
            contentView.backgroundColor = .energyCollectionViewGreen
            titleLabel.text = "Add Auto\nTop-Up"
            imageView.image = UIImage(named: "auto-top-up")
        default:
            contentView.backgroundColor = .energyCollectionViewRed
            titleLabel.text = "Enerjiyə Qənaət\nMəsləhətləri"
            imageView.image = UIImage(named: "energy-savings")
        }
    }
}
