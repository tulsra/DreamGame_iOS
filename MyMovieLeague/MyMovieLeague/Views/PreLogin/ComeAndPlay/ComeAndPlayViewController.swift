//
//  ComeAndPlayViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class ComeAndPlayViewController: UIViewController {
    
    let movieNames = ["Radhe2", "Movie2", "Movie4"]

        
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnComeAndPlay: UIButton!
    @IBOutlet weak var imgViewMovieSlider: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in
            self.imgViewMovieSlider.image = UIImage(named: self.movieNames.randomElement() ?? "")
        }
        timer.fire()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-arrow-white"), style: .plain, target: nil, action: nil)
    }


    func setupUI() {
        self.btnComeAndPlay.layer.cornerRadius = 3.0
        self.btnComeAndPlay.layer.masksToBounds = true
    }
    @IBAction func btnComeAndPlayAction(_ sender: UIButton) {
        AppController.shared.loadMainView()
    }
    
    @IBAction func btnHelpAction(_ sender: UIButton) {
        let helpVC = HelpViewController()
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        let loginvVC = LoginViewController()
        self.navigationController?.pushViewController(loginvVC, animated: true)
    }
    
    deinit {
        print("DEINIT ComeAndPlayViewController")
    }

}
