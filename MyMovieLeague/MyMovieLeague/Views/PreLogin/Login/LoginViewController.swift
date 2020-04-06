//
//  LoginViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInDelegate {

    
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
            self.view.endEditing(true)
            self.showActivity()
            NetworkManager().post(method: .verifyPhoneNumber, urlParam: ["api-version":"v1.0"], bodyParm: ["phoneNumber":txtFieldPhoneNumber.text ?? ""]) { (response, error) in
                DispatchQueue.main.async {
                    self.hideActivity()
                    if let error = error {
                        self.view.makeToast(error, duration: 2.0, position: .center)
                    }
                    else {
                        let verifyVC = VerifyMobileViewController()
                        verifyVC.phoneNumber = self.txtFieldPhoneNumber.text ?? ""
                        self.navigationController?.pushViewController(verifyVC, animated: true)
                    }
                }
                
            }
        }
        else {
            self.view.makeToast("Please enter valid phone number", duration: 2.0, position: .center)
        }
        
    }

    @IBAction func facebookLogin(_ sender: Any) {
        
        let manager = LoginManager()
        manager.logOut()
            //,.userGender,.userHometown,.userBirthday,.userLocation
        manager.logIn(permissions: [.publicProfile,.email], viewController: self) { (result) in

            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("Cancelleddd")
            case .success(let grantedData, let declineData, let token):
                print(grantedData)
                print(declineData)
                print(token)
                self.getFbUserData()
                
            }
        }
        
    }
    
    func getFbUserData() {
        if let token = AccessToken.current {
            //We need get addintion permissioned rewviewwd by facebookto get following details
            //, user_hometown, user_location,user_gender,user_birthday
            GraphRequest(graphPath: "me", parameters: ["fields" : "id, first_name, last_name, picture.type(large), email"]).start { (connection, result, error) in
                guard let err =  error else {
                    if let result = result {
                        
                        let kResult = result as! [String:AnyObject]
                        print(result)
                    }
                    return
                }
                
                print(err)
            }
        }
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().clientID = "905397799104-ouonochq6bbkpago7mhp3b7k5ioijtuu.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    deinit {
        print("DEINIT LoginViewController")
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let err = error {
            print(err)
            return
        }
        
        guard let auth = user.authentication else { return }
        
        guard let userId = user.userID else { return }                  // For client-side use only!
        guard let idToken = user.authentication.idToken else { return } // Safe to send to the server
        guard let fullName = user.profile.name else { return }
        guard let givenName = user.profile.givenName else { return }
        guard let familyName = user.profile.familyName else { return }
        guard let email = user.profile.email else { return }
        
        print(user)
        print("\(givenName) \(familyName) \(email)")
        
        if user.profile.hasImage {
            print("\(user.profile.imageURL(withDimension: 400))")
        }
    }
}


extension LoginViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let updatedText = NSMutableString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if updatedText.count <= 10 {
            textField.text = updatedText
        }
        return false
    }
}
