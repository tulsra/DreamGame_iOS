//
//  AppController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import UIKit

let themeColor = UIColor(red: 254.0/255.0, green: 0, blue: 66.0/255.0, alpha: 1.0)
class AppController {
    static let shared = AppController()
    private init(){}

    var window: UIWindow?
    var mainView   =   SSASideMenu()
    
    func loadStartView() {
        window?.rootViewController  =   nil
        
        let splashVC                 =   SplashViewController()
        let navigationController = UINavigationController(rootViewController: splashVC)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController  =   navigationController
        setNavigationBarAppearance()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            if family.lowercased().contains("Poppins".lowercased()) || family.lowercased().contains("Roboto".lowercased()) || family.lowercased().contains("SansSerif".lowercased()) {
                for name in names {
                    print("\(name)")
                }
            }
        }
    }
    
    
    func loadMainView() {
        window?.rootViewController  =   nil
        let VC1 =   MainTabbarViewController()
               let VC2 =   SideViewController()
               let nav = UINavigationController(rootViewController: VC1)
               mainView   =   SSASideMenu(contentViewController: nav, leftMenuViewController: VC2)
               window?.rootViewController  =    mainView
               
               VC2.menuTapped = { index in
                   print(index)
                   if index == 7 {
                       self.logout()
                   }
                   else if index == 4 {

                       let pointSystem = PointSystemViewController()
                       let nav1 = UINavigationController(rootViewController: pointSystem)
                       VC1.present(nav1, animated: true, completion: nil)
                   }
                   else if index == 5 {

                       let termsAndConditions = TermsAndConditionsViewController()
                       let nav1 = UINavigationController(rootViewController: termsAndConditions)
                       VC1.present(nav1, animated: true, completion: nil)
                   }
                   else {
                       //VC1.selectedIndex = index
                   }
               }
        setNavigationBarAppearance()
    }
    
    
    func loadComeAndPlay() {
        window?.rootViewController  =   nil
        let comeAndPlayVC                 =   ComeAndPlayViewController()
        let navigationController = UINavigationController(rootViewController: comeAndPlayVC)
        window?.rootViewController  =   navigationController
        setNavigationBarAppearance()

    }
    
    func setNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.2)
        UINavigationBar.appearance().isTranslucent = true
    }
    
    
    func addNavigationButtons(navigationItem:UINavigationItem) {
        let logo = UIImage(named: "app-logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        navigationItem.titleView = imageView
        
        let menubutton = UIButton(type: .custom)
        menubutton.setImage(UIImage(named: "menu"), for: .normal)
        menubutton.addTarget(self, action: #selector(menuBtnAction), for: .touchUpInside)
        
        let barButton1 = UIBarButtonItem(customView: menubutton)
        
        let currWidth1 = barButton1.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth1?.isActive = true
        let currHeight1 = barButton1.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight1?.isActive = true
        navigationItem.leftBarButtonItem = barButton1
        
        
        let lopgoutbutton = UIButton(type: .custom)
        lopgoutbutton.setImage(UIImage(named: "notification-2"), for: .normal)
        lopgoutbutton.addTarget(self, action: #selector(notificationAction), for: .touchUpInside)
        
        let barButton2 = UIBarButtonItem(customView: lopgoutbutton)
        
        let currWidth2 = barButton2.customView?.widthAnchor.constraint(equalToConstant: 28)
        currWidth2?.isActive = true
        let currHeight2 = barButton2.customView?.heightAnchor.constraint(equalToConstant: 28)
        currHeight2?.isActive = true
        navigationItem.rightBarButtonItem = barButton2
        
    }
    
    
    @objc func menuBtnAction() {
         self.mainView.contentViewController?.presentLeftMenuViewController()
    }
    
    
    @objc func notificationAction() {
        
        let notificatonVC = NotificationViewController()
        (self.mainView.contentViewController as! UINavigationController).pushViewController(notificatonVC, animated: true)
                
    }
    
    func logout() {
        let alert = UIAlertController(title: "MY MOVIE LEAGUE", message: "Are You Sure Want to Logout!", preferredStyle:.alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.forceLogoutAction()
        }
        let noButton = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    func forceLogoutAction() {
        clearAuthToken()
        clearUserDetails()
        AppController.shared.loadStartView()
    }
    
}


func addTransitionEffect(view:UIView) {
    let animation: CATransition = CATransition()
    animation.type  =   CATransitionType.fade
    animation.duration  =   0.25
    animation.subtype   =   CATransitionSubtype.fromRight
    animation.timingFunction    =   CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    view.layer.add(animation, forKey: "fadeViewAnimation")
}

func GetAppDelegate() -> AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
}


func clearUserDetails() {
    UserDefaults.standard.removeObject(forKey: "LoginUserData")
    UserDefaults.standard.synchronize()
}

func saveAuthToken(token:String) {
    UserDefaults.standard.set(token, forKey: "AuthTokenForUser")
    UserDefaults.standard.synchronize()
}
func getAuthToken() -> String? {
    if let value = UserDefaults.standard.object(forKey: "AuthTokenForUser") {
        return value as? String
    }
    return nil
}
func clearAuthToken() {
    UserDefaults.standard.removeObject(forKey: "AuthTokenForUser")
    UserDefaults.standard.synchronize()
}

func getGmailTypeImageFromString(str:String, bgcolor:UIColor) -> UIImage {
    let lblNameInitialize = UILabel()
    lblNameInitialize.frame.size = CGSize(width: 60.0, height: 60.0)
    lblNameInitialize.textColor = UIColor.white
    lblNameInitialize.text = str.uppercased()
    lblNameInitialize.textAlignment = NSTextAlignment.center
    lblNameInitialize.backgroundColor = bgcolor
    lblNameInitialize.layer.cornerRadius = 30.0
    lblNameInitialize.font = UIFont.systemFont(ofSize: 21)
    
    UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
    lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
    let imageCap = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return imageCap ?? UIImage()
}

