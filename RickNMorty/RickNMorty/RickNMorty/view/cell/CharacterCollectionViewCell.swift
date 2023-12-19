//
//  CharacterCollectionViewCell.swift
//  RickNMorty
//
//  Created by Murad Ismayilov on 07.12.23.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCharacterImage()
        setUpNameLabel()
        setUpSpeciesLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpCharacterImage() {
        contentView.addSubview(characterImage)
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setUpSpeciesLabel() {
        contentView.addSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setUpCharacterCollectionViewCellContent(character: Character_) {
        
        if let imageUrl = URL(string: character.image ) {
            characterImage.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "questionmark"))
        }
        
        nameLabel.text = character.name
        speciesLabel.text = character.species
    }
}
