//
//  SideViewController.swift
//  BES
//
//  Created by Thulasi Ram Boddu on 22/08/19.
//  Copyright © 2019 Qentelli. All rights reserved.
//

import UIKit
//import SDWebImage
import MessageUI


class SideViewController: UIViewController {

    @IBOutlet weak var profileView: SideProfileView!
    @IBOutlet var menuCells: [SideMenuCell]!
        
    var menuTapped:(Int)->Void = { index in
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
//        profileView.user = AppController.shared.user
        profileView.editTapped = {
            let profileVC = AccountSummeryViewController()
            let nav = UINavigationController(rootViewController: profileVC)
            self.present(nav, animated: true, completion: nil)
            self.sideMenuViewController?.hideMenuViewController()

        }
        
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


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension SideViewController : MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
