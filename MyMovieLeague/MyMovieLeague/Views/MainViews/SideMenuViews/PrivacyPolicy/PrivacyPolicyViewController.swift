//
//  PrivacyPolicyViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

        override func viewDidLoad() {
           super.viewDidLoad()
           
           // Do any additional setup after loading the view.
           //let pdfView = PDFView()
           let pdfView = WKWebView()
           pdfView.translatesAutoresizingMaskIntoConstraints = false
           pdfView.contentMode = .scaleAspectFit
           //pdfView.autoScales = true
           view.addSubview(pdfView)
           
           pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
           pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
           pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
           pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
           
           /*
           guard let path = Bundle.main.url(forResource: "point-system", withExtension: "pdf") else { return }
           
           if let document = PDFDocument(url: path) {
               pdfView.document = document
           }
    */
           let url = URL(string: "https://www.mymovieleague.in/privacy.html")//"https://mymovieleague.in/howtoplay.html")
           pdfView.load(URLRequest(url: url!))
           
       }
       
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = false
           
           self.title = "PRIVACY POLICY"
           
           let menubutton = UIButton(type: .custom)
           menubutton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
           menubutton.setImage(UIImage(named: "close"), for: .normal)
           menubutton.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
           
           let barButton1 = UIBarButtonItem(customView: menubutton)
           let currWidth1 = barButton1.customView?.widthAnchor.constraint(equalToConstant: 18)
           currWidth1?.isActive = true
           let currHeight1 = barButton1.customView?.heightAnchor.constraint(equalToConstant: 18)
           currHeight1?.isActive = true
           navigationItem.rightBarButtonItem = barButton1
           
       }
       
       @objc func closeBtnAction() {
           self.dismiss(animated: true, completion: nil)
       }
       

}
