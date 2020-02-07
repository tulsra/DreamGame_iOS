//
//  PrizeBreakupTableViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 07/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class PrizeBreakupTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
              self.bgView.layer.masksToBounds = true
              self.bgView.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
