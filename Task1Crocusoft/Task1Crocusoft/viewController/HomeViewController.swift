//
//  HomeViewController.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 02.11.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let topView: TopView = {
        let view = TopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let roundedButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var energyCollectionView: UICollectionView!
    
    private let inviteView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite3
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "Xəbərlər"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .appBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlue
        
        setUpTop()
        
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(mainView)
        
        mainView.addSubview(holderView)
        
        setUpData()
        
        setUpButtons()
        
        setUpEnergyCollection()
        
        setUpInviteFriendsView()
        
        mainView.addSubview(newsLabel)
        
        setUpNewsCollection()
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
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
            holderView.widthAnchor.constraint(equalToConstant: 50),
            
            newsLabel.topAnchor.constraint(equalTo: inviteView.bottomAnchor, constant: 16),
            newsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setUpTop() {
        view.addSubview(topView)
                        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setUpData() {
        let leftDataStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 18
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let leftDataStackViewTopLabel: UILabel = {
            let label = UILabel()
            label.text = "Sizin Sərfiyyat"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            label.textColor = .appBlue
            return label
        }()
        
        let leftInnerDataStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let leftDataStackViewMiddleLabel: UILabel = {
            let label = UILabel()
            label.text = "25.98"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 30)
            label.textColor = .appBlue
            return label
        }()
        
        let leftDataStackViewMiddleImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "manat"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let leftDataStackViewBottomLabel: UILabel = {
            let label = UILabel()
            label.text = "limiti keçmisiniz"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
            label.textColor = .appBlue
            return label
        }()
        
        let rightDataStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let rightDataStackViewFirstLabel: UILabel = {
            let label = UILabel()
            label.text = "344.45"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 36)
            label.textColor = .appBlue
            return label
        }()
        
        let rightDataStackViewSecondLabel: UILabel = {
            let label = UILabel()
            label.text = "KW/s"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 36)
            label.textColor = .appBlue
            return label
        }()
        
        mainView.addSubview(dataStackView)
        
        dataStackView.addArrangedSubview(leftDataStackView)
        
        leftDataStackView.addArrangedSubview(leftDataStackViewTopLabel)
        leftDataStackView.addArrangedSubview(leftInnerDataStackView)
        leftInnerDataStackView.addArrangedSubview(leftDataStackViewMiddleLabel)
        leftInnerDataStackView.addArrangedSubview(leftDataStackViewMiddleImageView)
        leftDataStackView.addArrangedSubview(leftDataStackViewBottomLabel)
        
        dataStackView.addArrangedSubview(rightDataStackView)
        
        rightDataStackView.addArrangedSubview(rightDataStackViewFirstLabel)
        rightDataStackView.addArrangedSubview(rightDataStackViewSecondLabel)
        
        NSLayoutConstraint.activate([
            dataStackView.topAnchor.constraint(equalTo: holderView.bottomAnchor, constant: 16),
            dataStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
            dataStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            
            leftDataStackViewMiddleImageView.heightAnchor.constraint(equalToConstant: 20),
            leftDataStackViewMiddleImageView.widthAnchor.constraint(equalToConstant: 26),
        ])
    }
    
    private func setUpButtons() {
        let increaseBalanceButton: UIButton =  {
            let button = UIButton()
            button.setTitle("Balansı artırmaq", for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .appBlue
            button.layer.cornerRadius = 15
            return button
        }()
        
        let goToPaymentsButton: UIButton =  {
            let button = UIButton()
            button.setTitle("Ödənişlərə keçid", for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            button.setTitleColor(.appBlue, for: .normal)
            button.backgroundColor = .appWhite2
            button.layer.cornerRadius = 15
            return button
        }()
        
        mainView.addSubview(roundedButtonsStackView)
        
        roundedButtonsStackView.addArrangedSubview(increaseBalanceButton)
        roundedButtonsStackView.addArrangedSubview(goToPaymentsButton)
        
        NSLayoutConstraint.activate([
            roundedButtonsStackView.topAnchor.constraint(equalTo: dataStackView.bottomAnchor, constant: 26),
            roundedButtonsStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            increaseBalanceButton.heightAnchor.constraint(equalToConstant: 32),
            increaseBalanceButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func setUpEnergyCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 228, height: 146)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        energyCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        energyCollectionView.register(EnergyCollectionViewCell.self, forCellWithReuseIdentifier: "EnergyCollectionViewCell")
        energyCollectionView.dataSource = self
        energyCollectionView.delegate = self
        energyCollectionView.backgroundColor = .clear
        energyCollectionView.showsHorizontalScrollIndicator = false
        energyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(energyCollectionView)
        
        NSLayoutConstraint.activate([
            energyCollectionView.topAnchor.constraint(equalTo: roundedButtonsStackView.bottomAnchor, constant: 34),
            energyCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            energyCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            energyCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setUpInviteFriendsView() {
        let imageView = UIImageView(image: UIImage(named: "gift"))
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        
        let mutableStr = NSMutableAttributedString(
            string: "Invite friends and get free bonuses",
            attributes:
                [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        mutableStr.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor(.appRed), range: NSRange(location: 23, length: 12))
        
        let secondLabel = UILabel()
        secondLabel.textColor = .appBlue
        secondLabel.attributedText = mutableStr
        secondLabel.numberOfLines = 0
        secondLabel.translatesAutoresizingMaskIntoConstraints  = false
        
        inviteView.addSubview(imageView)
        inviteView.addSubview(secondLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .appWhite4
        stackView.layer.cornerRadius = 15
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let spacerView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        button.setImage(UIImage(named: "share"), for: .normal)
        
        let shareLabel = UILabel()
        shareLabel.textColor = .appBlue2
        shareLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        shareLabel.backgroundColor = .white
        shareLabel.text = " https://invite.azerishiq.az/Ohs69OhHBhd9nj"
        shareLabel.layer.masksToBounds = true
        shareLabel.layer.cornerRadius = 12
        
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(shareLabel)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(spacerView1)
        
        inviteView.addSubview(stackView)
        mainView.addSubview(inviteView)
        
        NSLayoutConstraint.activate([
            secondLabel.leadingAnchor.constraint(equalTo: inviteView.leadingAnchor, constant: 55),
            secondLabel.topAnchor.constraint(equalTo: inviteView.topAnchor, constant: 38),
            secondLabel.widthAnchor.constraint(equalToConstant: 170),
            
            imageView.trailingAnchor.constraint(equalTo: inviteView.trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: inviteView.topAnchor, constant: 15),
            
            shareLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 3),
            shareLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -3),
            shareLabel.widthAnchor.constraint(equalToConstant: 215),
            
            stackView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: inviteView.leadingAnchor, constant: 15),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            stackView.heightAnchor.constraint(equalToConstant: 32),
            
            inviteView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            inviteView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            inviteView.topAnchor.constraint(equalTo: energyCollectionView.bottomAnchor, constant: 20),
            inviteView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setUpNewsCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 160)
        layout.minimumInteritemSpacing = 10
        
        newsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: mainScrollView.frame.size.width, height: 150), collectionViewLayout: layout)
        newsCollectionView.showsHorizontalScrollIndicator = false
        newsCollectionView.backgroundColor = .clear
        newsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(newsCollectionView)
        
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 16),
            newsCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            newsCollectionView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == energyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnergyCollectionViewCell", for: indexPath) as! EnergyCollectionViewCell
            cell.setUpEnergyCollectionViewCellContent(index: indexPath.row)
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.masksToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            cell.setUpCollectionViewCellContent(index: indexPath.row)
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.masksToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(PaymentViewController(), animated: true, completion: nil)
    }
}
