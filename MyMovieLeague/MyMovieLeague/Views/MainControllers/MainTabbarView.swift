//
//  MainTabbarView.swift
//  BES
//
//  Created by Thulasi Ram Boddu on 22/08/19.
//  Copyright © 2019 Qentelli. All rights reserved.
//

import Foundation
import UIKit

class MainTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
//        self.view.backgroundColor   =   UIColor.clear
   
        let home     =   GameCardViewController()
        let homeBarItem = UITabBarItem(title: "Home".uppercased(), image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        home.tabBarItem = homeBarItem
        
        let gamesVC = MoviesListViewController()
        let locationsBarItem = UITabBarItem(title: "Games".uppercased(), image: UIImage(named: "games"), selectedImage: UIImage(named: "games"))
        gamesVC.tabBarItem = locationsBarItem
    
        let resultsVC = UIViewController()
        let invoiceBarItem = UITabBarItem(title: "Results".uppercased(), image: UIImage(named: "winners"), selectedImage: UIImage(named: "winners"))
        resultsVC.tabBarItem = invoiceBarItem

        let accountVC = UIViewController()
        let documentationBarItem = UITabBarItem(title: "Account".uppercased(), image: UIImage(named: "account"), selectedImage: UIImage(named: "account"))

        accountVC.tabBarItem = documentationBarItem
        
        self.viewControllers = [home, gamesVC, resultsVC, accountVC]
    
        //Tabbar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = themeColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeColor]
        self.tabBar.standardAppearance = appearance

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppController.shared.addNavigationButtons(navigationItem: self.navigationItem)
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MainTabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == moreNavigationController {
            moreNavigationController.navigationBar.topItem?.rightBarButtonItem = nil
        }
    }
    
}

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}
