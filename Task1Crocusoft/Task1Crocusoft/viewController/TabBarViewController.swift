//
//  TabBarViewController.swift
//  Task1Crocusoft
//
//  Created by Murad Ismayilov on 04.11.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let homeViewController = self.createNav(with: "Əsas", and: UIImage(named: "home"), viewController: HomeViewController())
        let paymentViewController = self.createNav(with: "Ödəmələr", and: UIImage(named: "payment"), viewController: PaymentViewController())
        let serviceViewController = self.createNav(with: "Xidmətlər", and: UIImage(named: "service"), viewController: ServiceViewController())
        let analysisViewController = self.createNav(with: "Göstəricilər", and: UIImage(named: "analysis"), viewController: AnalysisViewController())
        let moreViewController = self.createNav(with: "Daha çox", and: UIImage(named: "more"), viewController: MoreViewController())
        
        self.setViewControllers([
            homeViewController,
            paymentViewController,
            serviceViewController,
            analysisViewController,
            moreViewController
        ], animated: true)
        
        self.tabBar.tintColor = .appRed
        self.tabBar.backgroundColor = .appWhite
    }
    
    private func createNav(with title: String, and image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        return navigationController
    }
}
