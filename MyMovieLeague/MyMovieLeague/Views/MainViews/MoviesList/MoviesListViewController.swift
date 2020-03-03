//
//  MoviesListViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 17/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
     let cellReuseIdendifier = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        self.title = "BOX OFFICE GAMES"
        
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


extension MoviesListViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (((UIScreen.main.bounds.size.width - 60)/2.0) * (4.0/3.0)) + 44
        }
        return (((UIScreen.main.bounds.size.width - 60)/2.0) * (4.0/3.0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! MovieTableViewCell
        
        if indexPath.section == 0 {
            cell.isCurrent = true
            cell.moviesList = ["Recent1","Recent2","Recent3","Recent4"]
            cell.titlesList = ["Tanhaji", "Street Dancer 3", "Good Newwz", "Panga"]
            cell.genreList = ["Patriotic Drama", "--", "Off beat Comedy", "--"]
            cell.releaseDateList = ["23/5/2020", "--", "25/12/2020", "--"]
            cell.releaseTimeList = ["Non-Festival Season", "--", "Holiday Season (Christmas)", "--"]
            cell.expectedRanges = [[["10-12 crs","12-14 crs","14-16 crs"],["35-45 crs","45-55 crs","55-65 crs"],["60-70 crs","70-85 crs","85-95 crs"],["75-105 crs","105-135 crs","135-155 crs"],["125-150 crs","150-175 crs","175-230 crs"]],
                                   [[]],
                                   [["15-20 crs","20-25 crs ","25-30 crs"],["45-60 crs","60-80 crs","80-100 crs"],["100-110 crs","110-120 crs","120-130 crs"],["140-170 crs","170-200 crs","200-220 crs"],["200-240 crs","240-280 crs","280-300 crs"]],
                                   []]
            cell.stars = [[(Star(JSON: ["id":1,
                                       "name":"Ajay Devgan",
                                       "role":"Actor",
                                       "imageUrl":"Ajay",
                                       "recentHistoy":[["id":1,
                                                        "movieTitle":"De De Pyaar De",
                                                        "movieGenre":"Off beat Comedy",
                                                        "verdict":"HIT",
                                                        "imageUrl":"History1",
                                                        "collection":["10.41 crs","38.54 crs","61.05 crs","103.64 crs","143.04 crs"]],
                ["id":2,
                "movieTitle":"Total Dhamaal",
                "movieGenre":"Comdey",
                "verdict":"SUPER HIT",
                "imageUrl":"History2",
                "collection":["16.5 crs","62.4 crs","94.55 crs","154.23 crs","228.27 crs"]],
                ["id":3,
                "movieTitle":"Raid",
                "movieGenre":"Suspense Thriller",
                "verdict":"SUPER HIT",
                "imageUrl":"History3",
                "collection":["10.04 crs","41.01 crs","63.05 crs","103.07 crs","153.62 crs"]],
                ["id":4,
                "movieTitle":"Golmaal Again",
                "movieGenre":"Comedy",
                "verdict":"BLOCKBUSTER",
                "imageUrl":"History4",
                "collection":["30.14 crs","87.6 crs","136.07 crs","205.69 crs","311.18 crs "]],
                ["id":5,
                "movieTitle":"Baadshaho",
                "movieGenre":"Historical Drama",
                "verdict":"AVERAGE",
                "imageUrl":"History5",
                "collection":["12.6 crs","43.3 crs","64.14 crs"," 78.1 crs","125.44 crs "]]]])!),
                (Star(JSON: ["id":2,
                "name":"Kajol",
                "role":"Actress",
                "imageUrl":"Kajol"])!),
                (Star(JSON: ["id":3,
                "name":"Saif Ali Khan",
                "role":"Actor",
                    "imageUrl":"Saif"])!)],
            [],
            [(Star(JSON: ["id":1,
            "name":"Akshay Kumar",
            "role":"Actor",
            "imageUrl":"Akshay",
            "recentHistoy":[
                ["id":1,
                "movieTitle":"Housefull 4",
                "movieGenre":"Comedy",
                "verdict":"SUPER HIT",
                "imageUrl":"History6",
                "collection":["16.5 crs","46.5 crs","129.35 crs","194.6 crs","280.27 crs"]],
                ["id":2,
                "movieTitle":"Mission Mangal",
                "movieGenre":"Space Thriller",
                "verdict":"BLOCKBUSTER",
                "imageUrl":"History7",
                "collection":["29.16 crs","97.56 crs","128.16 crs","202.98 crs","290.59 crs"]],
                ["id":3,
                "movieTitle":"Kesari",
                "movieGenre":"Patriotic Drama",
                "verdict":"HIT",
                "imageUrl":"History8",
                "collection":["21.06 crs","78.07 crs","105.86 crs","154.41 crs","207.09 crs"]]]])!),
             (Star(JSON: ["id":2,
            "name":"Kareena Kapoor",
            "role":"Actress",
            "imageUrl":"Kareena"])!),
             (Star(JSON: ["id":3,
            "name":"Kiara Advani",
            "role":"Actress",
            "imageUrl":"Kiara"])!)],
            []]
        }
        if indexPath.section == 1 {
            cell.isCurrent = false
            cell.moviesList = ["Upcoming1","Upcoming2","Upcoming3","Upcoming4"]
            cell.titlesList = ["83", "Sooryavanshi", "Coolie No 1", "Shubh Mangal Zyada Saavdhan"]
        }
    
        cell.collView.reloadData()
        
        cell.cellTapped = { (title,genre,releaseDate, releaseTime,image,expectedRange,stars) in
            let moviesListVC = GameCardViewController()
            moviesListVC.contests = self.getContestsData(title: title, genre: genre, releaseDate: releaseDate, releaseTime: releaseTime, image: image, expectedRanges: expectedRange,stars:stars)
            self.navigationController?.pushViewController(moviesListVC, animated: true)
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
        
        if section == 0 {
            titleLabel.text = "Current Games"
        }
        if section == 1 {
            titleLabel.text = "Upcoming Games"
        }
        view.addSubview(titleLabel)
        return view
    }
    
    func getContestsData(title:String, genre: String, releaseDate: String, releaseTime: String, image:String,expectedRanges:[[String]],stars:[Star])->[Contest] {
        
        let contest1 = Contest(JSON: ["id": 1,
                                      "title": "India Opening Day Collections",
                                      "movieTitle": title,
                                      "movieGenre": genre,
                                      "releaseDate": releaseDate,
                                      "releaseTime": releaseTime,
                                      "movieImageURL": image,
                                      "extepectedRanges":expectedRanges[0],
                                      "stars":stars.toJSON(),
                                      "gameCard": ["id": 1,
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
                                        ]]])
        
        let contest2 = Contest(JSON: ["id": 2,
                                      "title": "India Weekend Collections",
                                      "movieTitle": title,
                                      "movieGenre": genre,
                                      "releaseDate": releaseDate,
                                      "releaseTime": releaseTime,
                                      "movieImageURL": image,
                                      "extepectedRanges":expectedRanges[1],
                                      "stars":stars.toJSON(),
                                      "gameCard": ["id": 1,
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
                                        ]]])
        
        
        let contest3 = Contest(JSON: ["id": 3,
                                      "title": "India 1st week collections",
                                      "movieTitle": title,
                                      "movieGenre": genre,
                                      "releaseDate": releaseDate,
                                      "releaseTime": releaseTime,
                                      "movieImageURL": image,
                                      "extepectedRanges":expectedRanges[2],
                                      "stars":stars.toJSON(),
                                      "gameCard": ["id": 1,
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
                                        ]]])
        
        let contest4 = Contest(JSON: ["id": 4,
                                      "title": "India Net Box Office Collections",
                                      "movieTitle": title,
                                      "movieGenre": genre,
                                      "releaseDate": releaseDate,
                                      "releaseTime": releaseTime,
                                      "movieImageURL": image,
                                      "extepectedRanges":expectedRanges[3],
                                      "stars":stars.toJSON(),
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
                                      "title": "World Wide Gross Box office Collections",
                                      "movieTitle": title,
                                      "movieGenre": genre,
                                      "releaseDate": releaseDate,
                                      "releaseTime": releaseTime,
                                      "movieImageURL": image,
                                      "extepectedRanges":expectedRanges[4],
                                      "stars":stars.toJSON(),
                                      "gameCard": ["id": 1,
                                                    "title": "World Wide Gross Box office Collections",
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
                                        ]]])
        
        if let contest1 = contest1, let contest2 = contest2, let contest3 = contest3, let contest4 = contest4, let contest5 = contest5 {
            return [contest1, contest2, contest3, contest4, contest5]
        }
        return []
    }
    
}
