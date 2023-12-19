//
//  PaymentViewController.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 28.10.23.
//

import UIKit

class PaymentViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ödəmələr"
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
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Sizin Sərfiyyat"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = .appBlue3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "14.04.2023"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let limitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let increaseBalanceButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Balansı artırmaq", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var limitCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlue
        
        setUpTop()
        
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(mainView)
        
        mainView.addSubview(holderView)
        
        mainView.addSubview(firstLabel)
        
        setUpPrice()
        
        mainView.addSubview(dateLabel)
        
        setUpLimit()
        
        mainView.addSubview(increaseBalanceButton)
        
        setUpLimitCollection()
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            // TODO: unwanted height of the ScrollView. Scrolling's getting disabled without the bottom constraint, so, commented it out for now.
            //mainView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            mainView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            
            holderView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            holderView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            holderView.heightAnchor.constraint(equalToConstant: 10),
            holderView.widthAnchor.constraint(equalToConstant: 50),
            
            firstLabel.topAnchor.constraint(equalTo: holderView.bottomAnchor, constant: 32),
            firstLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 18),
            dateLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            increaseBalanceButton.topAnchor.constraint(equalTo: limitStackView.bottomAnchor, constant: 18),
            increaseBalanceButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            increaseBalanceButton.heightAnchor.constraint(equalToConstant: 32),
            increaseBalanceButton.widthAnchor.constraint(equalToConstant: 170)
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
    
    private func setUpPrice() {
        let label: UILabel = {
            let label = UILabel()
            label.text = "25.98"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 60)
            label.textColor = .appBlue
            return label
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "manat"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        mainView.addSubview(priceStackView)
        
        // TODO: StackView is not being arranged according to the Label size, it arranges the size for the Image. So the Label looks a bit off. The Home view has the same issue.
        priceStackView.addArrangedSubview(label)
        priceStackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 20),
            priceStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpLimit() {
        let label: UILabel = {
            let label = UILabel()
            label.text = "limiti keçmisiniz"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
            label.textColor = .appBlue
            return label
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "limit"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        mainView.addSubview(limitStackView)
        
        limitStackView.addArrangedSubview(imageView)
        limitStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            limitStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            limitStackView.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 18),
            imageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setUpLimitCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 70)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        limitCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        limitCollectionView.register(LimitCollectionViewCell.self, forCellWithReuseIdentifier: "LimitCollectionViewCell")
        limitCollectionView.dataSource = self
        limitCollectionView.delegate = self
        limitCollectionView.backgroundColor = .clear
        limitCollectionView.showsVerticalScrollIndicator = false
        limitCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(limitCollectionView)
        
        NSLayoutConstraint.activate([
            limitCollectionView.topAnchor.constraint(equalTo: increaseBalanceButton.bottomAnchor, constant: 22),
            limitCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            limitCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            limitCollectionView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}

extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LimitCollectionViewCell", for: indexPath) as! LimitCollectionViewCell
        cell.setUpLimitCollectionViewCellContent(index: indexPath.row)
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(PaymentViewController(), animated: true, completion: nil)
    }
}
