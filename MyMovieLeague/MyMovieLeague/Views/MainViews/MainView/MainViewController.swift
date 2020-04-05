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
        
        if getAuthToken() == "" {
            
            self.title = "GAMES"
            
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
            
            let image: UIImage = UIImage(named: "app-logo-small")!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            self.navigationItem.titleView = imageView
            
        }
        
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
    
    @objc func backBtnAction() {
        AppController.shared.loadComeAndPlay()
    }

    @IBAction func btnBoxOfficeAction(_ sender: UIButton) {
        let moviesListVC = MoviesListViewController()
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    
    @IBAction func btnQuizAction(_ sender: UIButton) {
        let moviesListVC = QuizGameCardViewController()
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
