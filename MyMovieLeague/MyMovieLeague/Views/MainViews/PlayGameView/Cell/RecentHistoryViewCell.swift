//
//  MovieCollectionViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 26/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class RecentHistoryViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
     
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 3.0
    }
}
