//
//  TabBarViewController.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 06.11.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let homeViewController = self.createNav(with: "home", viewController: HomeViewController())
        let saveViewController = self.createNav(with: "save", viewController: SaveViewController())
        
        self.setViewControllers([
            homeViewController,
            saveViewController,
        ], animated: true)
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
    private func createNav(with image: String, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.image = UIImage(named: image)
        navigationController.tabBarItem.selectedImage = UIImage(named: "\(image).selected")
        
        return navigationController
    }
}
