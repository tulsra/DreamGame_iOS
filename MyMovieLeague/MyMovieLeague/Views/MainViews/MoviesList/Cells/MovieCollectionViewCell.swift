//
//  MovieCollectionViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 26/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnPlayHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBottomSpaceConstraint: NSLayoutConstraint!
    var movie: Movie?
    var recentBoxOffice: RecentBoxOffice?
    var cast: Cast?
    var cellMovieTapped:(Movie)->Void = { (movie) in
              
          }
    var cellRecentBoxOfficeTapped:(RecentBoxOffice)->Void = { (recentBoxOffice) in
        
    }
    var cellCastTapped:(Cast)->Void = { (cast) in
                 
             }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        self.btnPlay.layer.cornerRadius = 2.0
        self.btnPlay.layer.masksToBounds = true
        
        self.btnPlay.backgroundColor = UIColor.clear
        self.btnPlay.layer.cornerRadius = 20
        self.btnPlay.layer.borderWidth = 1.5
        self.btnPlay.layer.borderColor = themeColor.cgColor
        self.btnPlay.setTitleColor(themeColor, for: .normal)
        
        self.lblTitle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func configure(movie:Movie) {
        self.movie = movie
        self.lblTitle.text = movie.name
        if let urlString = movie.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  {
            if let url  = URL(string: urlString){
                self.imgView.sd_setImage(with: url, placeholderImage: nil , options:SDWebImageOptions.avoidAutoSetImage, completed: { (image, error, cacheType, url) in
                    DispatchQueue.main.async {
                        if let image = image, let pic = self.movie?.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), pic == url!.absoluteString {
                            self.imgView.image = image
                        }
                    }
                })
            }
        }
    }
    
    func configure(recentBxOfc:RecentBoxOffice) {
        self.recentBoxOffice = recentBxOfc
        
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 12.0)! ]
        let mutableAttrString1 = NSMutableAttributedString(string: (recentBoxOffice?.totalCollection?.crores ?? "").uppercased(), attributes: myAttribute)
        
        let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
        let mutableAttrString2 = NSMutableAttributedString(string: "\n" + (recentBoxOffice?.movieName ?? "").uppercased() , attributes: myAttribute1)
        
        let myAttribute3 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
        let mutableAttrString3 = NSMutableAttributedString(string: "\n" + (recentBoxOffice?.genre ?? "").capitalized , attributes: myAttribute3)
        
        let myAttribute4 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
        let mutableAttrString4 = NSMutableAttributedString(string: "\n" + (recentBoxOffice?.movieResult ?? "").uppercased() , attributes: myAttribute4)
        
        let combination = NSMutableAttributedString()
        combination.append(mutableAttrString1)
        combination.append(mutableAttrString2)
        combination.append(mutableAttrString3)
        combination.append(mutableAttrString4)
        self.lblTitle.attributedText = combination
        self.lblTitle.isHidden = true
        if let urlString = recentBoxOffice?.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  {
            if let url  = URL(string: urlString){
                self.imgView.sd_setImage(with: url, placeholderImage: nil , options:SDWebImageOptions.avoidAutoSetImage, completed: { (image, error, cacheType, url) in
                    DispatchQueue.main.async {
                        if let image = image, let pic = self.recentBoxOffice?.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), pic == url!.absoluteString {
                            self.imgView.image = image
                        }
                    }
                })
            }
        }
    }
    
    func configure(cast:Cast) {
        self.cast = cast
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 12.0)! ]
        let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
        
        let mutableAttrString1 = NSMutableAttributedString(string: (cast.name ?? "").uppercased(), attributes: myAttribute)
        let text = cast.castRole ?? ""
        let mutableAttrString2 = NSMutableAttributedString(string: "\n" + text.uppercased() , attributes: myAttribute1)
        let combination = NSMutableAttributedString()
        combination.append(mutableAttrString1)
        combination.append(mutableAttrString2)
        self.lblTitle.attributedText = combination
        
        if let urlString = self.cast?.castImgUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  {
            if let url  = URL(string: urlString){
                self.imgView.sd_setImage(with: url, placeholderImage: nil , options:SDWebImageOptions.avoidAutoSetImage, completed: { (image, error, cacheType, url) in
                    DispatchQueue.main.async {
                        if let image = image, let pic = self.cast?.castImgUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), pic == url!.absoluteString {
                            self.imgView.image = image
                        }
                    }
                })
            }
        }
    }
    
    func showTitle() {
        self.lblTitle.isHidden = !self.lblTitle.isHidden
    }
}
