//
//  GameCardViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 06/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class GameCardViewController: UIViewController {


    @IBOutlet weak var tblView: UITableView!
     let cellReuseIdendifier = "GameCardTableViewCell"
    var contests:[Contest] = [Contest]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        self.title = "My Games".uppercased()

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
        
//        let image: UIImage = UIImage(named: "app-logo-small")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        self.navigationItem.titleView = imageView
        
    }

    func setupUI() {
        
        self.tblView.register(UINib.init(nibName: cellReuseIdendifier, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier)
        
    }
    
    deinit {
        print("DEINIT GameCardViewController")
    }
    
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension GameCardViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.contests.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! GameCardTableViewCell
        cell.selectionStyle = .none
        if let game = self.contests[indexPath.section].gameCard {
        cell.lblTotalPrize.text = game.prizePool?.currencyStamped ?? ""
        cell.lblEntryFee.text = game.ticketPrice?.indianString?.currencyStamped ?? ""
        
        cell.lblFirstPrize.text = game.firstPrize?.indianString?.currencyStamped ?? ""
        cell.lblSecondPrize.text = game.secondPrize?.indianString?.currencyStamped ?? ""
        cell.lblThirdPrize.text = game.thirdPrize?.indianString?.currencyStamped ?? ""
        
        cell.lblLeftSpots.text = "\(game.usersLeft?.indianString ?? "") Players Left"
        cell.lblTotalSpots.text = "\(game.noOfUsers?.indianString ?? "") Players"
        
        }
        if indexPath.section == 0 {
        cell.timeLeftLabel.text = "03D 22H 13M Left"
        }
        if indexPath.section == 1 {
        cell.timeLeftLabel.text = "10D 22H 13M Left"
        }
        if indexPath.section == 2 {
        cell.timeLeftLabel.text = "27D 22H 13M Left"
        }
        if indexPath.section == 3 {
        cell.timeLeftLabel.text = "41D 22H 13M Left"
        }
        if indexPath.section == 4 {
        cell.timeLeftLabel.text = "75D 22H 13M Left"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        view.subviews.forEach{$0.removeFromSuperview()}
        view.backgroundColor = .clear
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 50))
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 18)
        
        titleLabel.text = self.contests[section].title?.uppercased()
        
        view.addSubview(titleLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let contest = self.contests[indexPath.section]
        let gamePlayCard = getGamePlayDummyCard(contest: contest, index: indexPath.section)
        
        let moviesListVC = PlayGameViewController()
        moviesListVC.gamePlayCard = gamePlayCard
        self.navigationController?.pushViewController(moviesListVC, animated: true)
        /*
        let moviesListVC = PrizeBreakupViewController()
        moviesListVC.gameCard = self.contests[indexPath.section].gameCard
        self.navigationController?.pushViewController(moviesListVC, animated: true)
 */
    }
    
}


extension GameCardViewController {
    
    func getGamePlayDummyCard(contest:Contest, index:Int)-> GamePlayCard? {
        
        let contest1 = Contest(JSON: contest.toJSON())
        contest1?.stars?.first?.recentHistoy?.forEach {
            $0.collection = [ $0.collection?[index] ?? ""]
        }
        
        return GamePlayCard(JSON: ["id":1,
                                   "movieTitle":contest1?.movieTitle!,
                                   "movieGenre": contest1?.movieGenre!,
                                   "releaseDate": contest1?.releaseDate!,
                                   "releaseTime": contest1?.releaseTime!,
                                   "movieImageURL":contest1?.movieImageURL!,
                                   "contestTitle":contest1?.title!,
                                   "ticketPrice":contest1?.gameCard?.ticketPrice ?? 0,
                                   "predictometerValue":25.56,
                                   "numberOfEntries":2,
                                   "extepectedRanges":contest1?.extepectedRanges ?? [],
                                   "stars":contest1?.stars?.toJSON() ?? []])
        
    }
    
}
