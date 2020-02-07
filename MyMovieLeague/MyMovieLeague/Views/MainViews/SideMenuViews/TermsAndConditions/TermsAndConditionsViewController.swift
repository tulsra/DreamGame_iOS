//
//  TermsAndConditionsViewController.swift
//  MyMovieLeague
//
//  Created by Tulasi on 08/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import PDFKit

class TermsAndConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.contentMode = .scaleAspectFit
        pdfView.autoScales = true
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        guard let path = Bundle.main.url(forResource: "Terms-and-Conditions-Template", withExtension: "pdf") else { return }

        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        self.title = "TERMS & CONDITIONS"
        
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
        
//        let image: UIImage = UIImage(named: "app-logo")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        self.navigationItem.titleView = imageView
    }
    
    @objc func closeBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
