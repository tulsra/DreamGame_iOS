//
//  SideViewController.swift
//  BES
//
//  Created by Thulasi Ram Boddu on 22/08/19.
//  Copyright © 2019 Qentelli. All rights reserved.
//

import UIKit
//import SDWebImage


class SideViewController: UIViewController {

    @IBOutlet weak var profileView: SideProfileView!
    @IBOutlet var menuCells: [SideMenuCell]!
        
    var menuTapped:(Int)->Void = { index in
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
//        profileView.user = AppController.shared.user
//        profileView.editTapped = {
//            let profileVC = ProfileViewController()
//            let nav = UINavigationController(rootViewController: profileVC)
//            self.present(nav, animated: true, completion: nil)
//            self.sideMenuViewController?.hideMenuViewController()
//
//        }
        
        menuCells.forEach {$0.btnClickAction = { tag in
            self.sideMenuViewController?.hideMenuViewController()
            self.menuTapped(tag)
            }}
        
                
//        self.profileView.user = AppController.shared.user
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        var parameters = ParameterDetail()
//        parameters.userId = "\(AppController.shared.user!.id!)"
//
//        if let parm = parameters.dictionary {
//
//            NetworkManager().get(method: .getUser, parameters: parm) { (result, error) in
//                DispatchQueue.main.async {
//                    if error != nil {
//                        return
//                    }
//                    AppController.shared.user = result as? User
//                    saveUserDetails(user: result as! User)
//                    self.profileView.user = AppController.shared.user
//                }
//            }
//
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

