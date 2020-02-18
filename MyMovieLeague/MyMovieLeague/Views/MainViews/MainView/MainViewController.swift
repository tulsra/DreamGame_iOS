//
//  MainViewController.swift
//  MyMovieLeague
//
//  Created by Tulasi on 29/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var viewQuizBG: UIView!
    @IBOutlet weak var viewBoxOfficeBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

//        self.title = "GAMES"
//        
//        let menubutton = UIButton(type: .custom)
//        menubutton.frame = CGRect(x: 0, y: 0, width: 18, height: 22)
//        menubutton.setImage(UIImage(named: "menu"), for: .normal)
//        menubutton.addTarget(self, action: #selector(menuBtnAction), for: .touchUpInside)
//        
//        let barButton1 = UIBarButtonItem(customView: menubutton)
//        let currWidth1 = barButton1.customView?.widthAnchor.constraint(equalToConstant: 18)
//        currWidth1?.isActive = true
//        let currHeight1 = barButton1.customView?.heightAnchor.constraint(equalToConstant: 22)
//        currHeight1?.isActive = true
//        navigationItem.leftBarButtonItem = barButton1
        
    
        
    }
    
    func setupUI() {
        self.viewQuizBG.backgroundColor = themeColor.withAlphaComponent(0.35)
        self.viewQuizBG.layer.masksToBounds = true
        self.viewQuizBG.layer.cornerRadius = 30
        self.viewQuizBG.layer.borderWidth = 1.0
        self.viewQuizBG.layer.borderColor = themeColor.withAlphaComponent(0.25).cgColor
        
        self.viewBoxOfficeBG.backgroundColor = themeColor.withAlphaComponent(0.35)
        self.viewBoxOfficeBG.layer.masksToBounds = true
        self.viewBoxOfficeBG.layer.cornerRadius = 30
        self.viewBoxOfficeBG.layer.borderWidth = 1.0
        self.viewBoxOfficeBG.layer.borderColor = themeColor.withAlphaComponent(0.25).cgColor
    }
    
    @objc func menuBtnAction() {
        
    }

    @IBAction func btnBoxOfficeAction(_ sender: UIButton) {
        let moviesListVC = AccountSummeryViewController()
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    
    @IBAction func btnQuizAction(_ sender: UIButton) {
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
