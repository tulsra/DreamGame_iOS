//
//  VerifyMobileViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class VerifyMobileViewController: UIViewController {

    
    @IBOutlet weak var imgViewOTPmobile: UIView!
    @IBOutlet weak var btnVerify: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "MOBILE VERIFICATION"
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
        self.btnVerify.layer.cornerRadius = 3.0
        self.btnVerify.layer.masksToBounds = true
        self.imgViewOTPmobile.layer.cornerRadius = self.imgViewOTPmobile.frame.size.width/2.0
        self.imgViewOTPmobile.layer.masksToBounds = true
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    func didFinishEnteringPin(pin:String) {

    }
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyAction(_ sender: UIButton) {
        
        let moviesListVC = MoviesListViewController()
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
           print("DEINIT VerifyMobileViewController")
       }

}
