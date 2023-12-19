//
//  SaveViewController.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 06.11.23.
//

import UIKit
import CoreData

class SaveViewController: UIViewController {
    
    private var saveCollectionView: UICollectionView!
    
    private var news = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        articles.removeAll()
        
        fetchSavedArticlesFromLocalDB()
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 80)
        layout.minimumLineSpacing = 34
        
        saveCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        saveCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "SaveCollectionViewCell")
        saveCollectionView.backgroundColor = .clear
        saveCollectionView.showsVerticalScrollIndicator = false
        saveCollectionView.dataSource = self
        saveCollectionView.delegate = self
        saveCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(saveCollectionView)
        
        NSLayoutConstraint.activate([
            saveCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            saveCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            saveCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            saveCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func fetchSavedArticlesFromLocalDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        do {
            news = try managedContext.fetch(fetchRequest)
            
            for i in news {
                
                let article = Article(
                    author: i.value(forKeyPath: "author") as? String,
                    title: i.value(forKeyPath: "title") as! String,
                    description: i.value(forKeyPath: "description") as? String,
                    url: i.value(forKeyPath: "url") as! String,
                    urlToImage: (i.value(forKeyPath: "urlToImage") as! String),
                    publishedAt: i.value(forKeyPath: "publishedAt") as! String,
                    content: (i.value(forKeyPath: "content") as! String))
                
                articles.append(article)
                articles.reverse()
            }
            
            saveCollectionView.reloadData()
        } catch let error as NSError {
            print("Couldn't fetch: \(error), \(error.userInfo)")
        }
    }
    
    @objc func saveCollectionItemClicked(index: Int) {
        let vc = DetailViewController()
        vc.article = articles[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SaveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SaveCollectionViewCell",
            for: indexPath) as! SecondCollectionViewCell
        
        Task {
            do {
                try await cell.setUpSecondCollectionViewCellContent(index: indexPath.row, articles: articles)
            } catch {
                print("Error while setting up the save collection")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        saveCollectionItemClicked(index: indexPath.row)
    }
}
