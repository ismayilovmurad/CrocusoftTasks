//
//  SecondCollectionViewCell.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 07.11.23.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    private let topicStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .appGray2
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 12)
        label.textColor = .appGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpTopic()
        
        contentView.addSubview(imageView)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topicStackView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 102),
            
            titleLabel.topAnchor.constraint(equalTo: topicStackView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: topicStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            authorLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8)
        ])
    }
    
    func setUpTopic() {
        contentView.addSubview(topicStackView)
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "Finance"
            label.font = UIFont(name: "Inter-Medium", size: 10)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        topicStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            topicStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topicStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topicStackView.heightAnchor.constraint(equalToConstant: 18),
            topicStackView.widthAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    func setUpSecondCollectionViewCellContent(index: Int, articles: [Article]) async throws {
        
        let article = articles[index]
        
        guard let imageUrl = URL(string: article.urlToImage ?? "https://picsum.photos/300/200/?blur") else {
            throw "The image URL could not be created."
        }
        
        imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "questionmark"))
        
//        Task {
//            let (data, response) = try await URLSession.shared.data(from: imageUrl)
//            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                throw "The server responded with an error."
//            }
//            
//            imageView.image = UIImage(data: data)
//        }
        
        titleLabel.text = article.title
        dateLabel.text = String(describing: article.publishedAt.split(separator: "T").first!)
        authorLabel.text = article.author
    }
}
