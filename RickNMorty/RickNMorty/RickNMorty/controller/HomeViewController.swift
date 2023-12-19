//
//  HomeViewController.swift
//  RickNMorty
//
//  Created by Murad Ismayilov on 07.12.23.
//

import UIKit

class HomeViewController: UIViewController {

    private var characterCollectionView: UICollectionView!
    
    private var characters = [Character_]()
    
    private let refreshControl = UIRefreshControl()
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    private var totalPages = 1
    
    private var currentPage = 1
    
    private var filterCollectionView: UICollectionView!
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search..."
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .main
        
        setUpSearchTextField()
        setUpFilterCollectionView()
        setUpCharacterCollection()
        setUpActivityIndicatorView()
        performFetchingCharacters(currentPage: currentPage)
    }
    
    private func setUpSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.addTarget(self, action: #selector(performFilteringCharactersByName), for: .editingDidEndOnExit)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    private func setUpFilterCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 152, height: 28)
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionViewCell")
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(filterCollectionView)
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 14),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpCharacterCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 240)
        
        refreshControl.addTarget(self, action: #selector(refreshCharacters), for: .valueChanged)
        refreshControl.tintColor = .white
        
        characterCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        characterCollectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        characterCollectionView.backgroundColor = .clear
        characterCollectionView.contentInset = UIEdgeInsets(top: 38, left: 20, bottom: 0, right: 20)
        characterCollectionView.showsVerticalScrollIndicator = false
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        characterCollectionView.refreshControl = refreshControl
        characterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(characterCollectionView)
        
        NSLayoutConstraint.activate([
            characterCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor),
            characterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func refreshCharacters() {
        characters.removeAll()
        currentPage = 1
        performFetchingCharacters(currentPage: currentPage)
    }
    
    private func performFetchingCharacters(currentPage: Int) {
        CharacterService().fetchCharacters(page: currentPage, completion: {data, error in
            
            if error != nil {
                print("Error while fetching the characters: \(String(describing: error))")
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data ?? Data())
                    
                    self.characters.append(contentsOf: decodedResponse.results)
                    
                    self.totalPages = decodedResponse.info.pages
                    
                    // TODO: What's the difference between DispatchQueue.main.sync and DispatchQueue.main.async
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        
                        if self.refreshControl.isRefreshing {
                            self.refreshControl.endRefreshing()
                        }
                        
                        self.characterCollectionView.reloadData()
                    }
                }catch {
                    print("Error while decoding the data: \(String(describing: error))")
                }
            }
        })
    }
    
    private func setUpActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.center = characterCollectionView.center
        activityIndicatorView.color = .white
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
    
    private func performFilteringCharactersByGender(currentPage: Int, gender: String) {
        CharacterService().filterCharactersByGender(page: currentPage, gender: gender, completion: {data, error in
            
            if error != nil {
                print("Error while fetching the characters: \(String(describing: error))")
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data ?? Data())
                    
                    self.characters.append(contentsOf: decodedResponse.results)
                    
                    self.totalPages = decodedResponse.info.pages
                    
                    // TODO: What's the difference between DispatchQueue.main.sync and DispatchQueue.main.async
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        
                        if self.refreshControl.isRefreshing {
                            self.refreshControl.endRefreshing()
                        }
                        
                        self.characterCollectionView.reloadData()
                    }
                }catch {
                    print("Error while decoding the data: \(String(describing: error))")
                }
            }
        })
    }
    
    private func performFilteringCharactersByStatus(currentPage: Int, status: String) {
        CharacterService().filterCharactersByStatus(page: currentPage, status: status, completion: {data, error in
            
            if error != nil {
                print("Error while fetching the characters: \(String(describing: error))")
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data ?? Data())
                    
                    self.characters.append(contentsOf: decodedResponse.results)
                    
                    self.totalPages = decodedResponse.info.pages
                    
                    // TODO: What's the difference between DispatchQueue.main.sync and DispatchQueue.main.async
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        
                        if self.refreshControl.isRefreshing {
                            self.refreshControl.endRefreshing()
                        }
                        
                        self.characterCollectionView.reloadData()
                    }
                }catch {
                    print("Error while decoding the data: \(String(describing: error))")
                }
            }
        })
    }
    
    @objc private func performFilteringCharactersByName() {
        self.characters.removeAll()
        self.currentPage = 1
        self.activityIndicatorView.startAnimating()
        
        CharacterService().filterCharactersByName(page: currentPage, name: searchTextField.text ?? "", completion: {data, error in
            
            if error != nil {
                print("Error while fetching the characters: \(String(describing: error))")
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data ?? Data())
                    
                    self.characters.append(contentsOf: decodedResponse.results)
                    
                    self.totalPages = decodedResponse.info.pages
                    
                    // TODO: What's the difference between DispatchQueue.main.sync and DispatchQueue.main.async
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        
                        if self.refreshControl.isRefreshing {
                            self.refreshControl.endRefreshing()
                        }
                        
                        self.characterCollectionView.reloadData()
                    }
                }catch {
                    print("Error while decoding the data: \(String(describing: error))")
                }
            }
        })
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == characterCollectionView {
            return characters.count
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == characterCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
            
            cell.setUpCharacterCollectionViewCellContent(character: characters[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            
            cell.setUpFilterCollectionViewCellContent(index: indexPath.row, actionClosure: { action in
                cell.filterButton.setTitle(action.title, for: .normal)
                if indexPath.row == 0 {
                    self.characters.removeAll()
                    self.currentPage = 1
                    self.activityIndicatorView.startAnimating()
                    self.performFilteringCharactersByGender(currentPage: self.currentPage, gender: action.title)
                } else {
                    self.characters.removeAll()
                    self.currentPage = 1
                    self.activityIndicatorView.startAnimating()
                    self.performFilteringCharactersByStatus(currentPage: self.currentPage, status: action.title)
                }
            })
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        if currentPage < totalPages && indexPath.row == characters.count-1 {
            currentPage += 1
            performFetchingCharacters(currentPage: currentPage)
        }
    }
}
