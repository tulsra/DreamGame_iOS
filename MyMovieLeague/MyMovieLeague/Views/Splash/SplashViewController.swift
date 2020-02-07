//
//  SplashViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
        
    }
    
    @objc func delayedAction() {
        AppController.shared.loadComeAndPlay()
    }
    
    deinit {
        print("DEINIT SplashViewController")
    }
    
}
