//
//  ViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func loadActivity() {
        self.view.isUserInteractionEnabled = false
        self.view.makeToastActivity(ToastPosition.center)
    }
    func hideActivity() {
        self.view.isUserInteractionEnabled = true
        self.view.hideToastActivity()
    }
}
