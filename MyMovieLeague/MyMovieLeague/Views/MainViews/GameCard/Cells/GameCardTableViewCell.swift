//
//  GameCardTableViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 06/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class GameCardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var lblTotalPrize: UILabel!
    @IBOutlet weak var lblEntryFee: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var lblLeftSpots: UILabel!
    @IBOutlet weak var lblTotalSpots: UILabel!
    @IBOutlet weak var lblFirstPrize: UILabel!
    @IBOutlet weak var lblSecondPrize: UILabel!
    @IBOutlet weak var lblThirdPrize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.playBtn.layer.masksToBounds = true
        self.playBtn.layer.cornerRadius = 2.0
        self.lblEntryFee.layer.masksToBounds = true
        self.lblEntryFee.layer.cornerRadius = 2.0
        self.contentView.backgroundColor = UIColor.clear//UIColor.black.withAlphaComponent(0.2)
        self.backgroundColor = .clear
        self.stackView.backgroundColor = UIColor.clear
        self.stackView.layer.masksToBounds = true
        self.stackView.layer.cornerRadius = 4.0
        self.bgView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
