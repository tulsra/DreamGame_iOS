//
//  LoginViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "LOG IN"
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
        self.btnNext.layer.cornerRadius = 3.0
        self.btnNext.layer.masksToBounds = true
        self.btnFacebook.layer.cornerRadius = 3.0
        self.btnFacebook.layer.masksToBounds = true
        self.btnGoogle.layer.cornerRadius = 3.0
        self.btnGoogle.layer.masksToBounds = true
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNextAction(_ sender: UIButton) {
        if txtFieldPhoneNumber.text?.count == 10 {
            NetworkManager().post(method: .verifyPhoneNumber, urlParam: ["api-version":"v1.0"], bodyParm: ["phoneNumber":txtFieldPhoneNumber.text ?? ""]) { (response, error) in
                
            }
        }
        let verifyVC = VerifyMobileViewController()
        self.navigationController?.pushViewController(verifyVC, animated: true)
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
        print("DEINIT LoginViewController")
    }

}
