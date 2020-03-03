//
//  QuizGameCardViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 02/03/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit

class QuizGameCardViewController: UIViewController {
   
        @IBOutlet weak var tblView: UITableView!
         let cellReuseIdendifier = "QuizGameCardTableViewCell"
        var contests:[QuizContest] = [QuizContest]()
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            getGamePlayDummyCard()
            setupUI()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false

//            self.title = "My Games".uppercased()

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

        func setupUI() {
            
            self.tblView.estimatedRowHeight = 160.0
            self.tblView.rowHeight = UITableView.automaticDimension
            self.tblView.register(UINib.init(nibName: cellReuseIdendifier, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier)
            
        }
        
        deinit {
            print("DEINIT QuizGameCardViewController")
        }
        
        
        @objc func backBtnAction() {
            self.navigationController?.popViewController(animated: true)
        }
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }


    extension QuizGameCardViewController:UITableViewDelegate,UITableViewDataSource {
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return self.contests.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 180
//        }
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! QuizGameCardTableViewCell
            cell.selectionStyle = .none
            if let game = self.contests[indexPath.section].gameCard {
                cell.lblTotalPrize.text = game.numberOfQuestions
                cell.lblEntryFee.text = game.ticketPrice?.indianString?.currencyStamped ?? ""
            
          
            cell.lblLeftSpots.text = "\(game.usersLeft?.indianString ?? "") Players Left"
            cell.lblTotalSpots.text = "\(game.noOfUsers?.indianString ?? "") Players"
            
            }
            
            if indexPath.section > 0 {
                cell.lblPrizeDesc.text = cell.lblPrizeDesc.text?.replacingOccurrences(of: "200", with: "350")
            }
            if indexPath.section == 0 {
            cell.timeLeftLabel.text = "22H 13M Left"
            }
            if indexPath.section == 1 {
            cell.timeLeftLabel.text = "17H 54M Left"
            }
            if indexPath.section == 2 {
            cell.timeLeftLabel.text = "12H 46M Left"
            }
            if indexPath.section == 3 {
            cell.timeLeftLabel.text = "07H 33M Left"
            }
            if indexPath.section == 4 {
            cell.timeLeftLabel.text = "03H 04M Left"
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
            
//            let contest = self.contests[indexPath.section]
//            if let gamePlayCard = contest.gameCard?[indexPath.section] {
//
//            let moviesListVC = PlayGameViewController()
//            moviesListVC.gamePlayCard = gamePlayCard
//            self.navigationController?.pushViewController(moviesListVC, animated: true)
//            }
            /*
            let moviesListVC = PrizeBreakupViewController()
            moviesListVC.gameCard = self.contests[indexPath.section].gameCard
            self.navigationController?.pushViewController(moviesListVC, animated: true)
     */
        }
        
    }


    extension QuizGameCardViewController {
        
        func getGamePlayDummyCard(){
            
            let contest1 = QuizContest(JSON: ["id": 1,
            "title": "Multiple Choice Question Quiz Game",
            "gameCard": ["id": 1,
                          "title": "India Opening Day Collections",
                          "noOfUsers": 1000,
                          "ticketPrice": 50,
                          "usersLeft": 243,
                          "numberOfQuestions": "50",
                          ]])!
            let contest2 = QuizContest(JSON: ["id": 1,
            "title": "Image Quiz Game",
            "gameCard": ["id": 1,
                          "title": "India Opening Day Collections",
                          "noOfUsers": 1000,
                          "ticketPrice": 50,
                          "usersLeft": 243,
                          "numberOfQuestions": "30",
                          ]])!
            let contest3 = QuizContest(JSON: ["id": 1,
            "title": "Audio Quiz Game",
            "gameCard": ["id": 1,
                          "title": "India Opening Day Collections",
                          "noOfUsers": 1000,
                          "ticketPrice": 50,
                          "usersLeft": 243,
                          "numberOfQuestions": "30",
                          ]])!
            let contest4 = QuizContest(JSON: ["id": 1,
            "title": "Video Quiz Game",
            "gameCard": ["id": 1,
                          "title": "India Opening Day Collections",
                          "noOfUsers": 1000,
                          "ticketPrice": 50,
                          "usersLeft": 243,
                          "numberOfQuestions": "30",
                          ]])!
            self.contests = [contest1, contest2, contest3, contest4]
            
        }
        
    }
