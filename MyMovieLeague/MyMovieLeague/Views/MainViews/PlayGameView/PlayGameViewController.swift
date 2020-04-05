//
//  PlayGameViewController.swift
//  MyMovieLeague
//
//  Created by Tulasi on 20/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import GaugeMeterView
import PlugNPlay

class PlayGameViewController: UIViewController {

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblStarREcentHistory: UILabel!
    @IBOutlet weak var lblExpectedRange2: UILabel!
    @IBOutlet weak var lblExpectedRange3: UILabel!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var lblMovieDetails: UILabel!
    
    @IBOutlet weak var imgViewMovie: UIImageView!
    @IBOutlet weak var lblExpectedRane1: UILabel!
    @IBOutlet var cardViews: [UIView]!
    @IBOutlet var rangeLabels: [UILabel]!
     @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var gaugeMeterView: GaugeMeterView!
    @IBOutlet var playLabels: [UILabel]!
    @IBOutlet weak var castCollView: UICollectionView!
    @IBOutlet weak var recentCollView: UICollectionView!
    
    var cellTapped:()->Void = {
           
       }
    
    var gamePlayCard:GamePlayCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//        self.title = "JOIN GAME"
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
        
        let image: UIImage = UIImage(named: "app-logo-small")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
 
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinBtnAction(_ sender: Any) {
    
        let txnParm = PUMTxnParam()
        txnParm.phone = "9746234115"
        txnParm.email = "tulsra@gmail.com"
        txnParm.amount = "50"
        txnParm.environment = .test
        txnParm.firstname = "Thulasi Ram"
        txnParm.key = "merchantKey"
        txnParm.merchantid = "ppPcYYVb"
        txnParm.txnID = "txnID123"
        txnParm.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
        txnParm.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
        txnParm.productInfo = UIDevice.current.model
        txnParm.hashValue = ""
        
        PlugNPlay.presentPaymentViewController(withTxnParams: txnParm, on: UIViewController()) { (reponse, error, extraParm) in
            
        }
    }
    
    func setupUI() {
        self.castCollView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let width = 125
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: 125)

        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        castCollView.collectionViewLayout =  layout
        castCollView.translatesAutoresizingMaskIntoConstraints = false
        castCollView.delegate = self
        castCollView.dataSource = self
        
        
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.itemSize = CGSize(width: width, height: 125)

        layout1.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout1.scrollDirection = .horizontal
        layout1.minimumLineSpacing = 10
        layout1.minimumInteritemSpacing = 10
        self.recentCollView.register(UINib(nibName: "RecentHistoryViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentHistoryViewCell")
        self.recentCollView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        recentCollView.collectionViewLayout =  layout1
        recentCollView.translatesAutoresizingMaskIntoConstraints = false
        recentCollView.delegate = self
        recentCollView.dataSource = self
        
        
        gaugeMeterView.gaugeAngle = 30.0
        gaugeMeterView.arrowBorderColor = UIColor.white
        gaugeMeterView.gaugeRangeValuesColor = UIColor.white

        gaugeMeterView.ranges = [(value: 100.0, color: .blue, title: "Low"), (value: 200, color: .green, title: "Medium"), (value: 300.0, color: .red, title: "High")]

        gaugeMeterView.value = 20.0
        
        self.cardViews.forEach {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
        }
        self.textFields.forEach {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 4.0, height: 2.0))
            $0.leftView = leftView
            $0.leftViewMode = .always
            let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 4.0, height: 2.0))
            $0.rightView = rightView
            $0.rightViewMode = .always
        }
        self.rangeLabels.forEach {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
        }
        self.playLabels.forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
            if $0.tag == 0 {
                let greenColor = UIColor(red: 73.0/255.0, green: 163.0/255.0, blue: 90.0/255.0, alpha: 1.0)
                $0.backgroundColor = greenColor//.withAlphaComponent(0.2)
            }
        }
        
        
        if let gameCard = self.gamePlayCard {
            self.lblMovieTitle.text = ("GAME" + " - " + (gameCard.contestTitle ?? "")).uppercased()
            self.btnJoin.setTitle("PLAY (₹\(gameCard.ticketPrice ?? 0))", for: .normal)
            self.imgViewMovie.image = UIImage(named: gameCard.movieImageURL ?? "")
            
            self.lblExpectedRane1.text = gameCard.extepectedRanges?[0].uppercased()
            self.lblExpectedRange2.text = gameCard.extepectedRanges?[1].uppercased()
            self.lblExpectedRange3.text = gameCard.extepectedRanges?[2].uppercased()
            
            let combination = NSMutableAttributedString()
            combination.append(self.getAttriburedText(title: "Title", description: gameCard.movieTitle ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Genre", description: gameCard.movieGenre ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Release Date", description: gameCard.releaseDate ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Release Time", description: gameCard.releaseTime ?? ""))
            self.lblMovieDetails.attributedText = combination
        }
    }

}

extension PlayGameViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.recentCollView ? self.gamePlayCard?.stars?.first?.recentHistoy?.count ?? 0 : self.gamePlayCard?.stars?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.recentCollView {
            /*
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentHistoryViewCell", for: indexPath as IndexPath) as! RecentHistoryViewCell
            
            if let stars = self.gamePlayCard?.stars, stars.count > 0, let recent = stars.first?.recentHistoy {
                let history = recent[indexPath.row]
                cell.imgView.image = UIImage(named: history.imageUrl ?? "")
                
                let combination = NSMutableAttributedString()
                
                combination.append(self.getRecentAttributedText(title: "Collection", description: history.collection?.first ?? ""))
                combination.append(self.getNewLine())
                combination.append(self.getRecentAttributedText(title: "Title", description: history.movieTitle ?? ""))
                combination.append(self.getNewLine())
                combination.append(self.getRecentAttributedText(title: "Genre", description: history.movieGenre ?? ""))
                combination.append(self.getNewLine())
                combination.append(self.getRecentAttributedText(title: "Verdict", description: history.verdict ?? "", isUppercased: true))
              
                cell.lblTitle.attributedText = combination
                
            }
 */
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

                       cell.imgBottomSpaceConstraint.constant = 0
                       cell.btnPlayHeightConstraint.constant = 0
                      
                         cell.lblTitle.textAlignment = .left
                     if let stars = self.gamePlayCard?.stars, stars.count > 0, let recent = stars.first?.recentHistoy {
                      let history = recent[indexPath.row]
                          cell.imgView.image = UIImage(named: history.imageUrl ?? "")
                          
                          let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 12.0)! ]
                        let mutableAttrString1 = NSMutableAttributedString(string: (history.collection?.first ?? "").uppercased(), attributes: myAttribute)
                        
                          let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
                          let mutableAttrString2 = NSMutableAttributedString(string: "\n" + (history.movieTitle ?? "").uppercased() , attributes: myAttribute1)

                        let myAttribute3 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
                        let mutableAttrString3 = NSMutableAttributedString(string: "\n" + (history.movieGenre ?? "").capitalized , attributes: myAttribute3)

                        let myAttribute4 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
                        let mutableAttrString4 = NSMutableAttributedString(string: "\n" + (history.verdict ?? "").uppercased() , attributes: myAttribute4)
                        
                          let combination = NSMutableAttributedString()
                          combination.append(mutableAttrString1)
                          combination.append(mutableAttrString2)
                        combination.append(mutableAttrString3)
                        combination.append(mutableAttrString4)
                          cell.lblTitle.attributedText = combination
                          
                      }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

             cell.imgBottomSpaceConstraint.constant = 0
             cell.btnPlayHeightConstraint.constant = 0
            
               cell.lblTitle.textAlignment = .left
            if let stars = self.gamePlayCard?.stars, indexPath.count < stars.count {
                let star = stars[indexPath.row]
                cell.imgView.image = UIImage(named: star.imageUrl ?? "")
            
                let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 12.0)! ]
                let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 10.0)! ]
                
                
                let mutableAttrString1 = NSMutableAttributedString(string: (star.name ?? "").uppercased(), attributes: myAttribute)
                var text = star.role ?? ""
                let mutableAttrString2 = NSMutableAttributedString(string: "\n" + text.uppercased() , attributes: myAttribute1)
                let combination = NSMutableAttributedString()
                combination.append(mutableAttrString1)
                combination.append(mutableAttrString2)
                cell.lblTitle.attributedText = combination
                
            }
            return cell
        }
        
       
    }
    
    func getAttriburedText(title:String, description:String) -> NSMutableAttributedString {
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 15.0)! ]
        let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 15.0)! ]
        
        let mutableAttrString1 = NSMutableAttributedString(string: "\(title): ".uppercased(), attributes: myAttribute)
        let mutableAttrString2 = NSMutableAttributedString(string: description.capitalized , attributes: myAttribute1)
        let combination = NSMutableAttributedString()
        combination.append(mutableAttrString1)
        combination.append(mutableAttrString2)
        
        return combination
    }
    func getRecentAttributedText(title:String, description:String, isUppercased:Bool = false) -> NSMutableAttributedString {
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 12.0)! ]
        let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 12.0)! ]
        
        let mutableAttrString1 = NSMutableAttributedString(string: "\(title): ".uppercased(), attributes: myAttribute)
        let mutableAttrString2 = NSMutableAttributedString(string: (isUppercased ? description.uppercased() : description.capitalized) , attributes: myAttribute1)
        let combination = NSMutableAttributedString()
        combination.append(mutableAttrString1)
        combination.append(mutableAttrString2)
        
        return combination
    }
    
    func getNewLine() -> NSMutableAttributedString {
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 15.0)! ]
        return NSMutableAttributedString(string: "\n", attributes: myAttribute)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 125 * (3.0/4.0), height: 125 )
        return collectionView == self.recentCollView ? CGSize(width: (125 + 125), height: 125 ) : CGSize(width: 125 * (3.0/4.0), height: 125 )
      
    }

    // item spacing = vertical spacing in horizontal flow
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // line spacing = horizontal spacing in horizontal flow
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.cellTapped()
  }
  
}
