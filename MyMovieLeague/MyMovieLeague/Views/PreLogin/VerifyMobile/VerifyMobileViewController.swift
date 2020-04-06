//
//  VerifyMobileViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import Alamofire

class VerifyMobileViewController: UIViewController {

    
    @IBOutlet weak var lblSentTo: UILabel!
    @IBOutlet weak var pinView: PinView!
    @IBOutlet weak var imgViewOTPmobile: UIView!
    @IBOutlet weak var btnVerify: UIButton!
    var phoneNumber: String = ""
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
        self.lblSentTo.text = "OTP sent to \(self.phoneNumber)"
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
        print(self.pinView.pinText)
        if self.pinView.pinText.count == 6 {
            self.showActivity()
            let bodyPArm = ["phone_number":self.phoneNumber,
                            "grant_type":"phone_number_token",
                            "verification_token":pinView.pinText,
                            "client_id":"pn_auth",
                            "client_secret":"secret"]
            
            NetworkManager().post(method: .verifyToken, urlParam: nil, bodyParm: bodyPArm) { (response, error) in
                DispatchQueue.main.async {
                    self.hideActivity()
                    if let error = error {
                        self.view.makeToast(error, duration: 2.0, position: .center)
                    }
                    else {
                        saveAuthToken(token: (response as? String) ?? "")
                        AppController.shared.loadMainView()
                    }
                }
            }
            
        }
        else {
            self.view.makeToast("Please enter valid OTP", duration: 2.0, position: .center)
        }
    }
    
    deinit {
           print("DEINIT VerifyMobileViewController")
       }

}
