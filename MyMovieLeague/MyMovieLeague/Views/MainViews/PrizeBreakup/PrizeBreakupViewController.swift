//
//  PrizeBreakupViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 07/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class PrizeBreakupViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
     let cellReuseIdendifier = "GameCardTableViewCell"
    let cellReuseIdendifier1 = "PrizeBreakupHeaaderTableViewCell"
    let cellReuseIdendifier2 = "PrizeBreakupTableViewCell"
    var movie:Movie?
    var contest:Contest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        self.title = self.contest?.contestName?.uppercased() ?? ""

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
        
//        let image: UIImage = UIImage(named: "app-logo")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        self.navigationItem.titleView = imageView
    }

    func setupUI() {
        
        self.tblView.register(UINib.init(nibName: cellReuseIdendifier, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier)
        self.tblView.register(UINib.init(nibName: cellReuseIdendifier1, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier1)
        self.tblView.register(UINib.init(nibName: cellReuseIdendifier2, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier2)
        
    }
    
    deinit {
        print("DEINIT MoviesListViewController")
    }
    
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension PrizeBreakupViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.contest?.lstPoolPrizes?.count ?? 0) + (self.contest?.lstMinPoolPrizes?.count ?? 0) + 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if indexPath.row == 0 {
            return 170
        }
        if indexPath.row == 1 {
            return 64
        }
        if let count =  self.contest?.lstPoolPrizes?.count, indexPath.row == count + 2 {
             return 64
        }
        return 36
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! GameCardTableViewCell
            
            if let contest = self.contest {
                cell.lblTotalPrize.text = contest.poolPrize?.indianString?.currencyStamped ?? ""
                cell.lblEntryFee.text = contest.contestJoiningPrice?.currencyStamped ?? ""
                cell.lblFirstPrize.text = contest.firstPrizeAmount?.indianString?.currencyStamped ?? ""
                cell.lblSecondPrize.text = contest.secondPrizeAmount?.indianString?.currencyStamped ?? ""
                cell.lblThirdPrize.text = contest.thirdPrizeAmount?.indianString?.currencyStamped ?? ""

                cell.lblLeftSpots.text = "\(contest.remainingPoolSize?.indianString ?? "") Players Left"
                cell.lblTotalSpots.text = "\(contest.contestPoolSize?.indianString ?? "") Players"
                cell.lblMinPlayers.text = "Minimum: 20,000 Players"//"Minimum: \(contest.minPlayers?.indianString ?? "") Players"
                
                cell.completionHandler = { tag in
                    if let contest = self.contest, let movie = self.movie {
                        let moviesListVC = PlayGameViewController()
                        moviesListVC.contest = contest
                        moviesListVC.movie = movie
                        self.navigationController?.pushViewController(moviesListVC, animated: true)
                    }
                }
            }
            cell.timeLeftLabel.text = "41D 22H 13M Left"
                        
            return cell
        } else  if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier1, for: indexPath) as! PrizeBreakupHeaaderTableViewCell
            if let contest = self.contest {
                cell.lblTitle.text = "WINNING BREAKUP"
                cell.lblTotalPrize.text = contest.poolPrize?.indianString?.currencyStamped ?? ""
            }
            return cell
        }
        else if let count =  self.contest?.lstPoolPrizes?.count, indexPath.row > 1, indexPath.row < count + 2 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier2, for: indexPath) as! PrizeBreakupTableViewCell
            if let prizeBreakupArr = self.contest?.lstPoolPrizes {
                cell.lblRank.text = prizeBreakupArr[indexPath.row-2].rank
                cell.lblAmount.text = "\(prizeBreakupArr[indexPath.row-2].winningAmount ?? "")".currencyStamped //(prizeBreakupArr[indexPath.row-2].amount ?? 0).indianString?.currencyStamped
            }
            return cell
        }
        else  if let count =  self.contest?.lstPoolPrizes?.count, indexPath.row == count + 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier1, for: indexPath) as! PrizeBreakupHeaaderTableViewCell
                cell.lblTitle.text = "MINIMUM WINNING BREAKUP"
                cell.lblTotalPrize.text = "" //game.prizePool?.currencyStamped ?? ""
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier2, for: indexPath) as! PrizeBreakupTableViewCell
            if let prizeBreakupArr = self.contest?.lstPoolPrizes, let minBreakupArr = self.contest?.lstMinPoolPrizes {
                let count = prizeBreakupArr.count + 3
                cell.lblRank.text = minBreakupArr[indexPath.row - count].rank
                cell.lblAmount.text = "\(minBreakupArr[indexPath.row - count].winningAmount ?? "")".currencyStamped //(prizeBreakupArr[indexPath.row-2].amount ?? 0).indianString?.currencyStamped
            }
            return cell
        }
    }
    
}

