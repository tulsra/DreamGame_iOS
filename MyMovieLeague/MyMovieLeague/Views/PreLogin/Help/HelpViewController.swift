//
//  HelpViewController.swift
//  MyMovieLeague
//
//  Created by Tulasi on 29/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var categoryView: InputView!
    @IBOutlet weak var commentsView: CommentInputView!
     @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "SUPPORT"
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
        categoryView.txtField.text = ""
        commentsView.txtView.text = ""
        self.btnSubmit.layer.cornerRadius = 3.0
        self.btnSubmit.layer.masksToBounds = true
        categoryView.accessoryImgView.isHidden  =   false
        categoryView.accessoryImgBtn.isHidden = false
        categoryView.accessoryAction = { sender in
            self.view.endEditing(true)
        }
    }
    
    @objc func backBtnAction() {
        if getAuthToken() == "" {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        let alertVC     =   AcknowledgeViewController()
        alertVC.type    =   .Feedback
        alertVC.gobackHome = {
        }
        self.navigationController?.pushViewController(alertVC, animated: true)
    }
    
    
}

extension HelpViewController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.view.layoutIfNeeded()
    }
}
