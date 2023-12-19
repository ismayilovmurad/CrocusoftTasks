//
//  FilterCollectionViewCell.swift
//  RickNMorty
//
//  Created by Murad Ismayilov on 10.12.23.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    let filterButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.setTitleColor(.main, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .filterItemBackground
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFilterButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpFilterButton() {
        contentView.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setUpFilterCollectionViewCellContent(index: Int, actionClosure: @escaping (UIAction) -> Void) {
        
        var menuChildren: [UIMenuElement] = []
        
        switch index {
        case 0:
            filterButton.setTitle("Gender Types", for: .normal)
            for genderType in Gender.allCases {
                menuChildren.append(UIAction(title: genderType.rawValue, handler: actionClosure))
            }
        case 1:
            filterButton.setTitle("Status", for: .normal)
            for status in Status.allCases {
                menuChildren.append(UIAction(title: status.rawValue, handler: actionClosure))
            }
        default:
            break
        }
        
        filterButton.menu = UIMenu(options: .displayInline, children: menuChildren)
        filterButton.showsMenuAsPrimaryAction = true
        //filterButton.changesSelectionAsPrimaryAction = true
    }
}
