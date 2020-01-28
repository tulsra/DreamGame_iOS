//
//  MovieCollectionViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 26/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnPlayHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBottomSpaceConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        self.btnPlay.layer.cornerRadius = 2.0
        self.btnPlay.layer.masksToBounds = true
        self.lblTitle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
}
