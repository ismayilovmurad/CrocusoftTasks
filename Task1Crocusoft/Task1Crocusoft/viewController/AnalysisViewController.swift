//
//  AnalysisViewController.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 28.10.23.
//

import UIKit

class AnalysisViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Göstəricilər"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        label.textColor = .appWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .appWhite
        scrollView.layer.cornerRadius = 30
        scrollView.layer.maskedCorners = [
            .layerMaxXMinYCorner, .layerMinXMinYCorner]
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [
            .layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite2
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlue
        
        setUpTop()
        
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(mainView)
        
        mainView.addSubview(holderView)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            mainView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            
            holderView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            holderView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            holderView.heightAnchor.constraint(equalToConstant: 10),
            holderView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpTop() {
        let topButtonsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 22
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let profileButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "profile"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let notificationButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "bell"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(topButtonsStackView)
        
        topButtonsStackView.addArrangedSubview(profileButton)
        topButtonsStackView.addArrangedSubview(notificationButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            topButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topButtonsStackView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            profileButton.widthAnchor.constraint(equalToConstant: 30),
            
            notificationButton.heightAnchor.constraint(equalToConstant: 30),
            notificationButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
