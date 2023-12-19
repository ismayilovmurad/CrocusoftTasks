//
//  DetailViewController.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 06.11.23.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var article: Article? = nil
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 13)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .appGray3
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 24
        stackView.layer.maskedCorners = [
            .layerMaxXMinYCorner, .layerMinXMinYCorner]
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topicStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .appGray2
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .appBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let excerptLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .appGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readMoreButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Read more...", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Bold", size: 12)
        button.setTitleColor(.appBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 13)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .appGray3
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        
        setUpViews()
        
        if checkIfSavedAlready() {
            saveButton.setTitle("Saved", for: .normal)
        }
    }
    
    private func setUpViews() {
        Task {
            do {
                try await setBackgroundImageView()
                setUpBackButton()
                setUpSaveButton()
                setUpMainStackView()
                setUpTopic()
                setUpTitle()
                setUpAuthor()
                setUpExcerpt()
                setUpDescription()
                setUpReadMoreButton()
            } catch {
                print(error)
            }
        }
    }
    
    private func setBackgroundImageView() async throws {
        view.addSubview(backgroundImageView)
        
        guard let imageUrl = URL(string: article?.urlToImage ?? "https://picsum.photos/300/200/?blur") else {
            throw "The image URL could not be created."
        }
        
        Task {
            let (data, response) = try await URLSession.shared.data(from: imageUrl)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw "The server responded with an error."
            }
            
            backgroundImageView.image = UIImage(data: data)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUpBackButton() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
        
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            backButton.widthAnchor.constraint(equalToConstant: 50)
//        ])
    }
    
    @objc private func back() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setUpSaveButton() {
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    @objc private func save() {
        if article != nil {
            if !checkIfSavedAlready() {
                PersistenceManager.shared.save(article: article!)
                
                articles.append(article!)
                
                saveButton.setTitle("Saved", for: .normal)
            } else {
                print("Already exists")
                saveButton.setTitle("Save", for: .normal)
                fetchSavedArticlesFromLocalDB()
            }
        }
    }
    
    private func checkIfSavedAlready() -> Bool {
        for i in articles {
            if i.url == article!.url {
                return true
            }
        }
        
        return false
    }
    
    private func setUpMainStackView() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setUpTopic() {
        mainStackView.addSubview(topicStackView)
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "News"
            label.font = UIFont(name: "Inter-Medium", size: 13)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        topicStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            topicStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 18),
            topicStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 34),
            topicStackView.heightAnchor.constraint(equalToConstant: 22),
            topicStackView.widthAnchor.constraint(equalToConstant: 86)
        ])
    }
    
    private func setUpTitle() {
        mainStackView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topicStackView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
        
        titleLabel.text = article?.title
    }
    
    private func setUpAuthor() {
        mainStackView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
        
        authorLabel.text = article?.author
    }
    
    private func setUpExcerpt() {
        mainStackView.addSubview(excerptLabel)
        
        NSLayoutConstraint.activate([
            excerptLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            excerptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            excerptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
        
        excerptLabel.text = article?.description
    }
    
    private func setUpDescription() {
        mainStackView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: excerptLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
        
        descriptionLabel.text = article?.content
    }
    
    private func setUpReadMoreButton() {
        
        mainStackView.addSubview(readMoreButton)
        
        readMoreButton.addTarget(self, action: #selector(openWeb), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            readMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
    }
    
    @objc private func openWeb() {
        if let url = URL(string: article?.url ?? "https://www.apple.com") {
            UIApplication.shared.open(url)
        }
    }
    
    private func unSave() {
        for i in savedNews {
            if i.value(forKeyPath: "url") as! String == article!.url {
                
                PersistenceManager.shared.delete(object: i)
                
                print("deleted")
            }
        }
    }
    
    private func fetchSavedArticlesFromLocalDB() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        savedNews = PersistenceManager.shared.fetch(request: fetchRequest).compactMap{$0}
        
        unSave()
    }
}
