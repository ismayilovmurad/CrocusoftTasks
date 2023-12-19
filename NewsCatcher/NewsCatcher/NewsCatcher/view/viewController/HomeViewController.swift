//
//  HomeViewController.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 06.11.23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    private let topStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 13)
        label.textColor = .appGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var firstCollectionView: UICollectionView!
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search..."
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let languageButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 13)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .appGray3
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var secondCollectionView: UICollectionView!
    
    private var topArticles = [Article]()
    private var searchArticles = [Article]()
        
    private var gestureRecognizer: UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpKeyboardDisposal()
        
        setUpTop()
        
        setUpDate()
        
        setUpFirstCollection()
        
        setUpSearchTextField()
        
        setUpLanguageView()
        
        setUpSecondCollection()
        
        performFetchingTopHeadlines()
        
        fetchSavedArticlesFromLocalDB()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        languageButton.setTitle(LANGUAGE, for: .normal)
        
        if !searchArticles.isEmpty {
            performSearch()
        }
    }
    
    private func setUpKeyboardDisposal() {
        gestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow() {
        view.addGestureRecognizer(gestureRecognizer!)
    }
    
    @objc private func keyboardWillHide() {
        view.removeGestureRecognizer(gestureRecognizer!)
    }
    
    private func setUpTop() {
        view.addSubview(topStack)
        
        let imageView: UIImageView = {
            let image = UIImageView(image: UIImage(named: "ellipse"))
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "News Catcher"
            label.font = UIFont(name: "Inter-Bold", size: 20)
            return label
        }()
        
        topStack.addArrangedSubview(imageView)
        topStack.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            imageView.widthAnchor.constraint(equalToConstant: 18),
            imageView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setUpDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        dateLabel.text = dateString
        
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 32),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28)
        ])
    }
    
    private func setUpFirstCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 180)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        firstCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "FirstCollectionViewCell")
        firstCollectionView.backgroundColor = .clear
        firstCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(firstCollectionView)
        
        NSLayoutConstraint.activate([
            firstCollectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 34),
            firstCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstCollectionView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    private func performFetchingTopHeadlines() {
        Task {
            do {
                try await topArticles = NewsService().fetchTopHeadlines()
                
                firstCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    @objc private func firstCollectionItemClicked(index: Int) {
        let vc = DetailViewController()
        vc.article = topArticles[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.addTarget(self, action: #selector(performSearch), for: .editingDidEndOnExit)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: firstCollectionView.bottomAnchor, constant: 26),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    @objc private func performSearch() {
        let query = searchTextField.text
        
        if query != nil {
            if !query!.isEmpty {
                Task {
                    do {
                        try await searchArticles = NewsService().search(query: query!)
                        
                        secondCollectionView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    private func setUpLanguageView() {
        view.addSubview(languageButton)
        
        languageButton.addTarget(self, action: #selector(openLanguagePage), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            languageButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 14),
            languageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            languageButton.widthAnchor.constraint(equalToConstant: 50),
            languageButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func openLanguagePage() {
        let vc = LanguageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpSecondCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 80)
        layout.minimumLineSpacing = 20
        
        secondCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "SecondCollectionViewCell")
        secondCollectionView.backgroundColor = .clear
        secondCollectionView.showsVerticalScrollIndicator = false
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(secondCollectionView)
        
        NSLayoutConstraint.activate([
            secondCollectionView.topAnchor.constraint(equalTo: languageButton.bottomAnchor, constant: 24),
            secondCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func secondCollectionItemClicked(index: Int) {
        let vc = DetailViewController()
        vc.article = searchArticles[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchSavedArticlesFromLocalDB() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        savedNews = PersistenceManager.shared.fetch(request: fetchRequest).compactMap{$0}
        
        for i in savedNews {
            
            let article = Article(
                author: i.value(forKeyPath: "author") as? String,
                title: i.value(forKeyPath: "title") as! String,
                description: i.value(forKeyPath: "description") as? String,
                url: i.value(forKeyPath: "url") as! String,
                urlToImage: (i.value(forKeyPath: "urlToImage") as! String),
                publishedAt: i.value(forKeyPath: "publishedAt") as! String,
                content: (i.value(forKeyPath: "content") as! String))
            
            articles.append(article)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return topArticles.count
        }
        return searchArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
            
            Task {
                do {
                    try await cell.setUpFirstCollectionViewCellContent(index: indexPath.row, articles: topArticles)
                    cell.contentView.layer.cornerRadius = 16
                    cell.contentView.layer.masksToBounds = true
                } catch {
                    print("Error while setting up the first collection")
                }
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
            
            Task {
                do {
                    try await cell.setUpSecondCollectionViewCellContent(index: indexPath.row, articles: searchArticles)
                } catch {
                    print("Error while setting up the second collection")
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCollectionView {
            firstCollectionItemClicked(index: indexPath.row)
        } else {
            secondCollectionItemClicked(index: indexPath.row)
        }
    }
}
