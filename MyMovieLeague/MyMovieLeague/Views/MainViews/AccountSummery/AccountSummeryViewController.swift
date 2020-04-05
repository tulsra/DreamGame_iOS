//
//  AccountSummeryViewController.swift
//  MyMovieLeague
//
//  Created by Tulasi on 18/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class AccountSummeryViewController: UIViewController {

    @IBOutlet var leaderShipViews: [UIView]!
    @IBOutlet var playingHistoryViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }


     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false

            self.title = "Account Summery".uppercased()

            let menubutton = UIButton(type: .custom)
            menubutton.frame = CGRect(x: 0, y: 0, width: 18, height: 22)
            menubutton.setImage(UIImage(named: "back-arrow-white"), for: .normal)
            menubutton.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)

            let barButton1 = UIBarButtonItem(customView: menubutton)
            let currWidth1 = barButton1.customView?.widthAnchor.constraint(equalToConstant: 18)
            currWidth1?.isActive = true
            let currHeight1 = barButton1.customView?.heightAnchor.constraint(equalToConstant: 22)
            currHeight1?.isActive = true
            navigationItem.leftBarButtonItem = barButton1
            
    //        let image: UIImage = UIImage(named: "app-logo-small")!
    //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    //        imageView.contentMode = .scaleAspectFit
    //        imageView.image = image
    //        self.navigationItem.titleView = imageView
            
        }

        func setupUI() {
            
            self.leaderShipViews.forEach {
                $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 4.0
            }
            self.playingHistoryViews.forEach {
                $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 4.0
            }
            
        }
    @objc func backBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
