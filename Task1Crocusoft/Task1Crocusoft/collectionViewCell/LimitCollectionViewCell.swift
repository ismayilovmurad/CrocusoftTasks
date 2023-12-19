//
//  EnergyCollectionViewCell2.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 30.10.23.
//

import UIKit

class LimitCollectionViewCell: UICollectionViewCell {
    
    private let leftDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let leftInnerDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        return stackView
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "calendar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let leftLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = .appBlue4
        return label
    }()
    
    private let leftLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = .appBlue
        return label
    }()
    
    private let rightDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let rightLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = .appBlue
        return label
    }()
    
    private let rightLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = .appBlue
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .appWhite3
        
        contentView.addSubview(leftDataStackView)
        leftDataStackView.addArrangedSubview(leftInnerDataStackView)
        leftInnerDataStackView.addArrangedSubview(leftImageView)
        leftInnerDataStackView.addArrangedSubview(leftLabel1)
        leftDataStackView.addArrangedSubview(leftLabel2)
        contentView.addSubview(rightDataStackView)
        rightDataStackView.addArrangedSubview(rightLabel1)
        rightDataStackView.addArrangedSubview(rightLabel2)
        
        NSLayoutConstraint.activate([
            leftDataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftDataStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            leftImageView.heightAnchor.constraint(equalToConstant: 18),
            leftImageView.widthAnchor.constraint(equalToConstant: 18),
            
            rightDataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightDataStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setUpLimitCollectionViewCellContent(index: Int) {
        
        switch index {
        case 0:
            leftLabel1.text = "06.03.2023"
            leftLabel2.text = "30632 KW/s"
            rightLabel1.text = "165 kW/s"
            rightLabel2.text = "11.55 AZN"
        case 1:
            leftLabel1.text = "03.02.2023"
            leftLabel2.text = "30467 KW/s"
            rightLabel1.text = "274 kW/s"
            rightLabel2.text = "19.18 AZN"
        default:
            leftLabel1.text = "05.01.2023"
            leftLabel2.text = "30193 KW/s"
            rightLabel1.text = "382 kW/s"
            rightLabel2.text = "30.02 AZN"
        }
    }
}
