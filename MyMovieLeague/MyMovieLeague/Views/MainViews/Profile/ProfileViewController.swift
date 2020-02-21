//
//  ProfileViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 20/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "EDIT PROFILE"
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
    }
    
    func setupUI() {
        self.btnSubmit.layer.cornerRadius = 3.0
        self.btnSubmit.layer.masksToBounds = true
        
    }
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
