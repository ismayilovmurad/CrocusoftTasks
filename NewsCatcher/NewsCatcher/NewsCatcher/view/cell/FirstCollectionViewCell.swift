//
//  FirstCollectionViewCell.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 06.11.23.
//

import UIKit
import Kingfisher

class FirstCollectionViewCell: UICollectionViewCell {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.font = UIFont(name: "Inter-Bold", size: 18)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backgroundImageView)
        
        setUpTopic()
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18)
        ])
    }
    
    func setUpTopic() {
        contentView.addSubview(topicStackView)
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "News"
            label.font = UIFont(name: "Inter-Medium", size: 12)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        topicStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            topicStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            topicStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            topicStackView.heightAnchor.constraint(equalToConstant: 22),
            topicStackView.widthAnchor.constraint(equalToConstant: 86)
        ])
    }
    
    func setUpFirstCollectionViewCellContent(index: Int, articles: [Article]) async throws {
        
        let article = articles[index]
        
        guard let imageUrl = URL(string: article.urlToImage ?? "https://picsum.photos/300/200/?blur") else {
            throw "The image URL could not be created."
        }
        
        backgroundImageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "questionmark"))
        
//        Task {
//            let (data, response) = try await URLSession.shared.data(from: imageUrl)
//            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                throw "The server responded with an error."
//            }
//            
//            backgroundImageView.image = UIImage(data: data)
//        }
        
        titleLabel.text = article.title
    }
}
