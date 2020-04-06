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
import SDWebImage

class PlayGameViewController: UIViewController {

    @IBOutlet weak var lblNoCastDetails: UILabel!
    @IBOutlet weak var lblNoRecentHistory: UILabel!
    @IBOutlet weak var recentHistoryContainer: UIView!
    @IBOutlet weak var recentHistoryContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var recentHistoryBottomView: UIView!
    @IBOutlet weak var recentHistoryBottomViewHeight: NSLayoutConstraint!
    
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
    var movie:Movie?
    var contest:Contest?
    var contestDetails:ContestDetails?
    var recentBoxoffice:[RecentBoxOffice]?
    var cast:Cast?
    var cellTapped:()->Void = {
           
       }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getList()
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
    func loadData() {
        
        self.recentHistoryContainer.isHidden = false
        self.recentHistoryContainerHeight.constant = 165
        self.recentHistoryBottomView.isHidden = false
        self.recentHistoryBottomViewHeight.constant = 10
        
        self.lblNoRecentHistory.isHidden = false
        if self.recentBoxoffice?.count ?? 0 > 0 {
            self.lblNoRecentHistory.isHidden = true
        }
        
        self.lblNoCastDetails.isHidden = false
        if self.contestDetails?.lstCast?.count ?? 0 > 0 {
            self.lblNoCastDetails.isHidden = true
        }
        
        if let contest = self.contest, let contestDetail = self.contestDetails, let movie = self.movie {
            self.lblMovieTitle.text = ("GAME" + " - " + (contest.contestName ?? "")).uppercased()
            self.btnJoin.setTitle("PLAY (₹\(contest.contestJoiningPrice ?? ""))", for: .normal)
            
            if let urlString = self.movie?.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  {
                if let url  = URL(string: urlString){
                    self.imgViewMovie.sd_setImage(with: url, placeholderImage: nil , options:SDWebImageOptions.avoidAutoSetImage, completed: { (image, error, cacheType, url) in
                        DispatchQueue.main.async {
                            if let image = image, let pic = self.movie?.movieUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), pic == url!.absoluteString {
                                self.imgViewMovie.image = image
                            }
                        }
                    })
                }
            }
            
            self.lblExpectedRane1.text =   "\(contestDetails?.lstExpectedRange?[0].rangeFrom?.croresInt ?? "")-\(contestDetails?.lstExpectedRange?[0].rangeTo?.croresInt ?? "") CRS".uppercased()
            self.lblExpectedRange2.text = "\(contestDetails?.lstExpectedRange?[1].rangeFrom?.croresInt ?? "")-\(contestDetails?.lstExpectedRange?[1].rangeTo?.croresInt ?? "") CRS".uppercased()
            self.lblExpectedRange3.text = "\(contestDetails?.lstExpectedRange?[2].rangeFrom?.croresInt ?? "")-\(contestDetails?.lstExpectedRange?[2].rangeTo?.croresInt ?? "") CRS".uppercased()
            
            let combination = NSMutableAttributedString()
            combination.append(self.getAttriburedText(title: "Title", description: contestDetail.movieDetail?.name ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Genre", description: contestDetail.movieDetail?.name ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Release Date", description: contestDetail.movieDetail?.releaseDate?.date.displayDate ?? ""))
            combination.append(self.getNewLine())
            combination.append(self.getAttriburedText(title: "Release Time", description: contestDetail.movieDetail?.releaseSeason ?? ""))
            self.lblMovieDetails.attributedText = combination
            
            self.lblStarREcentHistory.text = "RECENT BOX-OFFICE HISTORY"
            if let cast = self.cast{
                self.lblStarREcentHistory.text = "\(cast.name ?? "") - RECENT BOX-OFFICE HISTORY".uppercased()
            }
        }
        self.recentCollView.reloadData()
        self.castCollView.reloadData()
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
    }
    
    @IBAction func recentHistoryCancelBtnAction(_ sender: Any) {
        self.recentHistoryContainer.isHidden = true
        self.recentHistoryContainerHeight.constant = 0
        self.recentHistoryBottomView.isHidden = true
        self.recentHistoryBottomViewHeight.constant = 0
    }
    

}

extension PlayGameViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.recentCollView ? self.recentBoxoffice?.count ?? 0 : self.contestDetails?.lstCast?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.recentCollView {
     
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell
            
            cell.imgBottomSpaceConstraint.constant = 0
            cell.btnPlayHeightConstraint.constant = 0
            cell.lblTitle.textAlignment = .left
            
            if let recent = self.recentBoxoffice, indexPath.row < recent.count {
                cell.configure(recentBxOfc: recent[indexPath.row])
            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell
            
            cell.imgBottomSpaceConstraint.constant = 0
            cell.btnPlayHeightConstraint.constant = 0
            
            cell.lblTitle.textAlignment = .left
            
            if let castList = self.contestDetails?.lstCast, indexPath.row < castList.count {
                cell.configure(cast: castList[indexPath.row])
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
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        if collectionView == self.recentCollView {
            cell.showTitle()
        }
        else {
            if let cast = cell.cast {
                self.cast = cast
                self.getRecentBoxoffice(castId: cast.castId ?? 0)
            }
        }
    }
  
}
