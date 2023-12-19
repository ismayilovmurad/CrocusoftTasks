//
//  TopView.swift
//  Task1Crocusoft
//
//  Created by Khayala Hasanli on 06.11.23.
//  Copyright © 2023 Khayala Hasanli. All rights reserved.


import UIKit

// MARK: - Custom top view example

class TopView: UIView {
    
    private let topTitlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel1 = UILabel(title: "Ana səhifə",
                                     font: UIFont(name: "SFProDisplay-Bold", size: 24) ?? .systemFont(ofSize: 24),
                                     textColor: .white)
    
    private let titleLabel2 = UILabel(title: "Xoş gəlmisən, Murad!",
                                     font: UIFont(name: "SFProDisplay-Bold", size: 24) ?? .systemFont(ofSize: 24),
                                     textColor: .red)

    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        return button
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(topTitlesStackView)
        addSubview(topButtonsStackView)
        
        topTitlesStackView.addArrangedSubview(titleLabel1)
        topTitlesStackView.addArrangedSubview(titleLabel2)
        
        topButtonsStackView.addArrangedSubview(profileButton)
        topButtonsStackView.addArrangedSubview(notificationButton)
        
        NSLayoutConstraint.activate([
            topTitlesStackView.topAnchor.constraint(equalTo: self.topAnchor),
            topTitlesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topTitlesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            topButtonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            topButtonsStackView.centerYAnchor.constraint(equalTo: topTitlesStackView.centerYAnchor)
        ])
    }
}


// MARK: - Convenience init example

extension UILabel {
    convenience init(title: String, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = title
        self.font = font
        self.textColor = textColor
    }
}
