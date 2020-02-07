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
        addDummyData()
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
        print("DEINIT MoviesListViewController")
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
        return self.contests[section].gameCard?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! GameCardTableViewCell
        cell.selectionStyle = .none
        if let games = self.contests[indexPath.section].gameCard, games.count > 0, let game = games.first {
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
        let moviesListVC = PrizeBreakupViewController()
        moviesListVC.gameCard = self.contests[indexPath.section].gameCard?.first
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    
}


extension GameCardViewController {
    func addDummyData() {
        let contest1 = Contest(JSON: ["id": 1,
                                      "title": "India Opening Day Collections",
                                      "gameCard": [["id": 1,
                                                    "title": "India Opening Day Collections",
                                                    "noOfUsers": 100000,
                                                    "ticketPrice": 20,
                                                    "firstPrize":10000,
                                                    "secondPrize":5000,
                                                    "thirdPrize":2500,
                                                    "usersLeft": 24368,
                                                    "prizePool": "20 Lakhs",
                                                    "prizeBreakup": [["id": 1,
                                                                      "order": 1,
                                                                      "rankFrom": 1,
                                                                      "rankTo": 1,
                                                                      "amount": 10000],
                                                                     ["id": 2,
                                                                      "order": 2,
                                                                      "rankFrom": 2,
                                                                      "rankTo": 2,
                                                                      "amount": 5000],
                                                                     ["id": 3,
                                                                      "order": 3,
                                                                      "rankFrom": 3,
                                                                      "rankTo": 3,
                                                                      "amount": 2500],
                                                                     ["id": 4,
                                                                      "order": 4,
                                                                      "rankFrom": 4,
                                                                      "rankTo": 10,
                                                                      "amount": 1000],
                                                                     ["id": 5,
                                                                      "order": 5,
                                                                      "rankFrom": 11,
                                                                      "rankTo": 20,
                                                                      "amount": 500],
                                                                     ["id": 6,
                                                                      "order": 6,
                                                                      "rankFrom": 21,
                                                                      "rankTo": 50,
                                                                      "amount": 250],
                                                                     ["id": 7,
                                                                      "order": 7,
                                                                      "rankFrom": 50,
                                                                      "rankTo": 100,
                                                                      "amount": 200],
                                                                     ["id": 8,
                                                                      "order": 8,
                                                                      "rankFrom": 101,
                                                                      "rankTo": 500,
                                                                      "amount": 150],
                                                                     ["id": 9,
                                                                      "order": 9,
                                                                      "rankFrom": 501,
                                                                      "rankTo": 1000,
                                                                      "amount": 100],
                                                                     ["id": 10,
                                                                      "order": 10,
                                                                      "rankFrom": 1001,
                                                                      "rankTo": 5000,
                                                                      "amount": 50],
                                                                     ["id": 11,
                                                                      "order": 11,
                                                                      "rankFrom": 5001,
                                                                      "rankTo": 10000,
                                                                      "amount": 30],
                                                                     ["id": 12,
                                                                      "order": 12,
                                                                      "rankFrom": 10001,
                                                                      "rankTo": 20000,
                                                                      "amount": 20],
                                                                     ["id": 13,
                                                                      "order": 13,
                                                                      "rankFrom": 20001,
                                                                      "rankTo": 50000,
                                                                      "amount": 10],
                                                                     ["id": 14,
                                                                      "order": 14,
                                                                      "rankFrom": 50001,
                                                                      "rankTo": 100000,
                                                                      "amount": 5]
                                        ]]]])
        
        let contest2 = Contest(JSON: ["id": 2,
                                      "title": "India Weekend Collections",
                                      "gameCard": [["id": 1,
                                                    "title": "India Weekend Collections",
                                                    "noOfUsers": 50000,
                                                    "ticketPrice": 30,
                                                    "firstPrize":25000,
                                                    "secondPrize":10000,
                                                    "thirdPrize":5000,
                                                    "usersLeft": 5368,
                                                    "prizePool": "15 Lakhs",
                                                    "prizeBreakup": [["id": 1,
                                                                      "order": 1,
                                                                      "rankFrom": 1,
                                                                      "rankTo": 1,
                                                                      "amount": 25000],
                                                                     ["id": 2,
                                                                      "order": 2,
                                                                      "rankFrom": 2,
                                                                      "rankTo": 2,
                                                                      "amount": 10000],
                                                                     ["id": 3,
                                                                      "order": 3,
                                                                      "rankFrom": 3,
                                                                      "rankTo": 3,
                                                                      "amount": 5000],
                                                                     ["id": 4,
                                                                      "order": 4,
                                                                      "rankFrom": 4,
                                                                      "rankTo": 6,
                                                                      "amount": 1000],
                                                                     ["id": 5,
                                                                      "order": 5,
                                                                      "rankFrom": 7,
                                                                      "rankTo": 10,
                                                                      "amount": 750],
                                                                     ["id": 6,
                                                                      "order": 6,
                                                                      "rankFrom": 11,
                                                                      "rankTo": 20,
                                                                      "amount": 500],
                                                                     ["id": 7,
                                                                      "order": 7,
                                                                      "rankFrom": 21,
                                                                      "rankTo": 30,
                                                                      "amount": 250],
                                                                     ["id": 8,
                                                                      "order": 8,
                                                                      "rankFrom": 31,
                                                                      "rankTo": 50,
                                                                      "amount": 200],
                                                                     ["id": 9,
                                                                      "order": 9,
                                                                      "rankFrom": 51,
                                                                      "rankTo": 80,
                                                                      "amount": 150],
                                                                     ["id": 10,
                                                                      "order": 10,
                                                                      "rankFrom": 81,
                                                                      "rankTo": 200,
                                                                      "amount": 100],
                                                                     ["id": 11,
                                                                      "order": 11,
                                                                      "rankFrom": 201,
                                                                      "rankTo": 300,
                                                                      "amount": 50],
                                                                     ["id": 12,
                                                                      "order": 12,
                                                                      "rankFrom": 301,
                                                                      "rankTo": 1000,
                                                                      "amount": 30],
                                                                     ["id": 13,
                                                                      "order": 13,
                                                                      "rankFrom": 1001,
                                                                      "rankTo": 10000,
                                                                      "amount": 20],
                                                                     ["id": 14,
                                                                      "order": 14,
                                                                      "rankFrom": 10001,
                                                                      "rankTo": 50000,
                                                                      "amount": 10]
                                        ]]]])
        
        
        let contest3 = Contest(JSON: ["id": 3,
                                      "title": "India 1st week collections",
                                      "gameCard": [["id": 1,
                                                    "title": "India 1st week collections",
                                                    "noOfUsers": 50000,
                                                    "ticketPrice": 40,
                                                    "firstPrize":50000,
                                                    "secondPrize":25000,
                                                    "thirdPrize":10000,
                                                    "usersLeft": 7833,
                                                    "prizePool": "20 Lakhs",
                                                    "prizeBreakup": [["id": 1,
                                                                      "order": 1,
                                                                      "rankFrom": 1,
                                                                      "rankTo": 1,
                                                                      "amount": 50000],
                                                                     ["id": 2,
                                                                      "order": 2,
                                                                      "rankFrom": 2,
                                                                      "rankTo": 2,
                                                                      "amount": 25000],
                                                                     ["id": 3,
                                                                      "order": 3,
                                                                      "rankFrom": 3,
                                                                      "rankTo": 3,
                                                                      "amount": 10000],
                                                                     ["id": 4,
                                                                      "order": 4,
                                                                      "rankFrom": 4,
                                                                      "rankTo": 6,
                                                                      "amount": 5000],
                                                                     ["id": 5,
                                                                      "order": 5,
                                                                      "rankFrom": 7,
                                                                      "rankTo": 10,
                                                                      "amount": 1000],
                                                                     ["id": 6,
                                                                      "order": 6,
                                                                      "rankFrom": 11,
                                                                      "rankTo": 20,
                                                                      "amount": 750],
                                                                     ["id": 7,
                                                                      "order": 7,
                                                                      "rankFrom": 21,
                                                                      "rankTo": 30,
                                                                      "amount": 500],
                                                                     ["id": 8,
                                                                      "order": 8,
                                                                      "rankFrom": 31,
                                                                      "rankTo": 50,
                                                                      "amount": 250],
                                                                     ["id": 9,
                                                                      "order": 9,
                                                                      "rankFrom": 51,
                                                                      "rankTo": 80,
                                                                      "amount": 200],
                                                                     ["id": 10,
                                                                      "order": 10,
                                                                      "rankFrom": 81,
                                                                      "rankTo": 200,
                                                                      "amount": 150],
                                                                     ["id": 11,
                                                                      "order": 11,
                                                                      "rankFrom": 201,
                                                                      "rankTo": 300,
                                                                      "amount": 100],
                                                                     ["id": 12,
                                                                      "order": 12,
                                                                      "rankFrom": 301,
                                                                      "rankTo": 1000,
                                                                      "amount": 70],
                                                                     ["id": 13,
                                                                      "order": 13,
                                                                      "rankFrom": 1001,
                                                                      "rankTo": 10000,
                                                                      "amount": 40],
                                                                     ["id": 14,
                                                                      "order": 14,
                                                                      "rankFrom": 10001,
                                                                      "rankTo": 50000,
                                                                      "amount": 20]
                                        ]]]])
        
        let contest4 = Contest(JSON: ["id": 4,
                                      "title": "India Net Box Office Collections",
                                      "gameCard": [["id": 1,
                                                    "title": "India Net Box Office Collections",
                                                    "noOfUsers": 50000,
                                                    "ticketPrice": 50,
                                                    "firstPrize":100000,
                                                    "secondPrize":50000,
                                                    "thirdPrize":25000,
                                                    "usersLeft": 13824,
                                                    "prizePool": "25 Lakhs",
                                                    "prizeBreakup": [["id": 1,
                                                                      "order": 1,
                                                                      "rankFrom": 1,
                                                                      "rankTo": 1,
                                                                      "amount": 100000],
                                                                     ["id": 2,
                                                                      "order": 2,
                                                                      "rankFrom": 2,
                                                                      "rankTo": 2,
                                                                      "amount": 50000],
                                                                     ["id": 3,
                                                                      "order": 3,
                                                                      "rankFrom": 3,
                                                                      "rankTo": 3,
                                                                      "amount": 25000],
                                                                     ["id": 4,
                                                                      "order": 4,
                                                                      "rankFrom": 4,
                                                                      "rankTo": 6,
                                                                      "amount": 10000],
                                                                     ["id": 5,
                                                                      "order": 5,
                                                                      "rankFrom": 7,
                                                                      "rankTo": 10,
                                                                      "amount": 5000],
                                                                     ["id": 6,
                                                                      "order": 6,
                                                                      "rankFrom": 11,
                                                                      "rankTo": 20,
                                                                      "amount": 1000],
                                                                     ["id": 7,
                                                                      "order": 7,
                                                                      "rankFrom": 21,
                                                                      "rankTo": 30,
                                                                      "amount": 500],
                                                                     ["id": 8,
                                                                      "order": 8,
                                                                      "rankFrom": 31,
                                                                      "rankTo": 50,
                                                                      "amount": 300],
                                                                     ["id": 9,
                                                                      "order": 9,
                                                                      "rankFrom": 51,
                                                                      "rankTo": 80,
                                                                      "amount": 200],
                                                                     ["id": 10,
                                                                      "order": 10,
                                                                      "rankFrom": 81,
                                                                      "rankTo": 200,
                                                                      "amount": 150],
                                                                     ["id": 11,
                                                                      "order": 11,
                                                                      "rankFrom": 201,
                                                                      "rankTo": 300,
                                                                      "amount": 100],
                                                                     ["id": 12,
                                                                      "order": 12,
                                                                      "rankFrom": 301,
                                                                      "rankTo": 1000,
                                                                      "amount": 70],
                                                                     ["id": 13,
                                                                      "order": 13,
                                                                      "rankFrom": 1001,
                                                                      "rankTo": 10000,
                                                                      "amount": 50],
                                                                     ["id": 14,
                                                                      "order": 14,
                                                                      "rankFrom": 10001,
                                                                      "rankTo": 50000,
                                                                      "amount": 25]
                                        ]]]])
        
        
        let contest5 = Contest(JSON: ["id": 5,
                                      "title": "World Wide Net Box office Collections",
                                      "gameCard": [["id": 1,
                                                    "title": "World Wide Net Box office Collections",
                                                    "noOfUsers": 50000,
                                                    "ticketPrice": 50,
                                                    "firstPrize":100000,
                                                    "secondPrize":50000,
                                                    "thirdPrize":25000,
                                                    "usersLeft": 24894,
                                                    "prizePool": "25 Lakhs",
                                                    "prizeBreakup": [["id": 1,
                                                                      "order": 1,
                                                                      "rankFrom": 1,
                                                                      "rankTo": 1,
                                                                      "amount": 100000],
                                                                     ["id": 2,
                                                                      "order": 2,
                                                                      "rankFrom": 2,
                                                                      "rankTo": 2,
                                                                      "amount": 50000],
                                                                     ["id": 3,
                                                                      "order": 3,
                                                                      "rankFrom": 3,
                                                                      "rankTo": 3,
                                                                      "amount": 25000],
                                                                     ["id": 4,
                                                                      "order": 4,
                                                                      "rankFrom": 4,
                                                                      "rankTo": 6,
                                                                      "amount": 10000],
                                                                     ["id": 5,
                                                                      "order": 5,
                                                                      "rankFrom": 7,
                                                                      "rankTo": 10,
                                                                      "amount": 5000],
                                                                     ["id": 6,
                                                                      "order": 6,
                                                                      "rankFrom": 11,
                                                                      "rankTo": 20,
                                                                      "amount": 1000],
                                                                     ["id": 7,
                                                                      "order": 7,
                                                                      "rankFrom": 21,
                                                                      "rankTo": 30,
                                                                      "amount": 500],
                                                                     ["id": 8,
                                                                      "order": 8,
                                                                      "rankFrom": 31,
                                                                      "rankTo": 50,
                                                                      "amount": 300],
                                                                     ["id": 9,
                                                                      "order": 9,
                                                                      "rankFrom": 51,
                                                                      "rankTo": 80,
                                                                      "amount": 200],
                                                                     ["id": 10,
                                                                      "order": 10,
                                                                      "rankFrom": 81,
                                                                      "rankTo": 200,
                                                                      "amount": 150],
                                                                     ["id": 11,
                                                                      "order": 11,
                                                                      "rankFrom": 201,
                                                                      "rankTo": 300,
                                                                      "amount": 100],
                                                                     ["id": 12,
                                                                      "order": 12,
                                                                      "rankFrom": 301,
                                                                      "rankTo": 1000,
                                                                      "amount": 70],
                                                                     ["id": 13,
                                                                      "order": 13,
                                                                      "rankFrom": 1001,
                                                                      "rankTo": 10000,
                                                                      "amount": 50],
                                                                     ["id": 14,
                                                                      "order": 14,
                                                                      "rankFrom": 10001,
                                                                      "rankTo": 50000,
                                                                      "amount": 25]
                                        ]]]])
        
        if let contest1 = contest1, let contest2 = contest2, let contest3 = contest3, let contest4 = contest4, let contest5 = contest5 {
            self.contests = [contest1, contest2, contest3, contest4, contest5]
        }
    }
}
