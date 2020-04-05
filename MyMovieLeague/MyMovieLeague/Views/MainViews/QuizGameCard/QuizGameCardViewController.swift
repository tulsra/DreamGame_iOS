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
//            return 200
//        }
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! QuizGameCardTableViewCell
            cell.selectionStyle = .none
            if let game = self.contests[indexPath.section].gameCard {
                cell.lblTotalPrize.text = "\(game.numberOfQuestions ?? 0)"
                cell.lblEntryFee.text = game.ticketPrice?.indianString?.currencyStamped ?? ""
                
            cell.lblMinPlayers.text = "Minimum: \(game.minPlayers?.indianString ?? "") Players"
            cell.lblDuration.text = "Duration: \(game.duration ?? "")"
          
            cell.lblLeftSpots.text = "\(game.usersLeft?.indianString ?? "") Players Left"
            cell.lblTotalSpots.text = "\(game.noOfUsers?.indianString ?? "") Players"
                cell.lblPrizeDesc.text = cell.lblPrizeDesc.text?.replacingOccurrences(of: "200", with: "\(game.prizePerQuestion?.indianString ?? "")").replacingOccurrences(of: "100", with: "\(game.minPrizePerQuestion?.indianString ?? "")")
            
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
            
            
            let moviesListVC = QuizPlayViewController()
            if let game = self.contests[indexPath.section].gameCard {
                moviesListVC.gameCard = game
            }
            self.navigationController?.pushViewController(moviesListVC, animated: true)
            
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
                                                           "title": "multiple",
                                                           "noOfUsers": 1000,
                                                           "ticketPrice": 50,
                                                           "usersLeft": 243,
                                                           "numberOfQuestions": 50,
                                                           "minPlayers": 500,
                                                           "duration": "8-10 mins",
                                                           "prizePerQuestion":200,
                                                           "minPrizePerQuestion":100,
                                                           "questions": [["id":1,
                                                                          "question":"Who is the director of Tanhaji?",
                                                                          "correctAnswer":4,
                                                                          "timerTime":20,
                                                                          "choices":[["id":1,
                                                                                      "choice":"Anurag Kashyap"],
                                                                                     ["id":2,
                                                                                      "choice":"Anurag Basu"],
                                                                                     ["id":3,
                                                                                      "choice":"Prakash Jha"],
                                                                                     ["id":4,
                                                                                      "choice":"Om Raut"]]],
                                                                         ["id":2,
                                                                          "question":"Wanted, A Bollywood Film featuring Salman Khan is the remake of which Telugu Film?",
                                                                          "correctAnswer":2,
                                                                          "timerTime":20,
                                                                          "choices":[["id":1,
                                                                                      "choice":"Athadu"],
                                                                                     ["id":2,
                                                                                      "choice":"Pokiri"],
                                                                                     ["id":3,
                                                                                      "choice":"Khaleja"],
                                                                                     ["id":4,
                                                                                      "choice":"Dookudu"]]],
                                                ["id":3,
                                                "question":"What is the birth name of Music Director, A.R. Rahman?",
                                                "correctAnswer":2,
                                                "timerTime":20,
                                                "choices":[["id":1,
                                                            "choice":"Abdul Aziz"],
                                                           ["id":2,
                                                            "choice":"Dileep Kumar"],
                                                           ["id":3,
                                                            "choice":"Gopal Krishna"],
                                                           ["id":4,
                                                            "choice":"Imtiaz Ali"]]],
                                                ["id":4,
                                                "question":"The movie, \"Udta Punjab\", featured a Male Punjabi singer in the lead. Who’s the singer?",
                                                "correctAnswer":1,
                                                "timerTime":20,
                                                "choices":[["id":1,
                                                            "choice":"Dilip Dosanjh"],
                                                           ["id":2,
                                                            "choice":"Honey Singh"],
                                                           ["id":3,
                                                            "choice":"Mika Singh"],
                                                           ["id":4,
                                                            "choice":"Daler Mehndi"]]],
                                                ["id":5,
                                                "question":"What was the name of the fictional city that the movie \"Saaho\" was based on?",
                                                "correctAnswer":4,
                                                "timerTime":20,
                                                "choices":[["id":1,
                                                            "choice":"Wadi City"],
                                                           ["id":2,
                                                            "choice":"Walid City"],
                                                           ["id":3,
                                                            "choice":"Wahi City"],
                                                           ["id":4,
                                                            "choice":"Waji City"]]]]
                ]])!
            let contest2 = QuizContest(JSON: ["id": 1,
                                              "title": "Image Quiz Game",
                                              "gameCard": ["id": 1,
                                                           "title": "image",
                                                           "noOfUsers": 1000,
                                                           "ticketPrice": 60,
                                                           "usersLeft": 243,
                                                           "numberOfQuestions": 30,
                                                           "minPlayers": 500,
                                                           "duration": "10-15 mins",
                                                           "prizePerQuestion":300,
                                                           "minPrizePerQuestion":150,
                                                           "questions": [["id":1,
                                                                          "question":"This image is from which movie?",
                                                                          "correctAnswer":1,
                                                                          "timerTime":20,
                                                                          "resourceURL": "ddljimage",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Dilwale Dulhania Le Jayenge"],
                                                                                     ["id":2,
                                                                                      "choice":"Kuch kuch hota hai"],
                                                                                     ["id":3,
                                                                                      "choice":"Baazigar"],
                                                                                     ["id":4,
                                                                                      "choice":"Dilwale"]]],
                                                                         ["id":2,
                                                                          "question":"What is the name of Bahubalis guru in this movie?",
                                                                          "correctAnswer":2,
                                                                          "timerTime":20,
                                                                          "resourceURL": "image2",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Redappa"],
                                                                                     ["id":2,
                                                                                      "choice":"Narappa"],
                                                                                     ["id":3,
                                                                                      "choice":"Sidhappa"],
                                                                                     ["id":4,
                                                                                      "choice":"Katappa"]]]]
                ]])!
            let contest3 = QuizContest(JSON: ["id": 1,
                                              "title": "Audio Quiz Game",
                                              "gameCard": ["id": 1,
                                                           "title": "audio",
                                                           "noOfUsers": 1000,
                                                           "ticketPrice": 70,
                                                           "usersLeft": 243,
                                                           "numberOfQuestions": 30,
                                                           "minPlayers": 500,
                                                           "duration": "10-15 mins",
                                                           "prizePerQuestion":400,
                                                           "minPrizePerQuestion":200,
                                                           "questions": [["id":1,
                                                                          "question":"This song, \"Ghungroo\" from the movie \"War\" featured which two actors?",
                                                                          "correctAnswer":4,
                                                                          "timerTime":20,
                                                                          "resourceURL": "audio1",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Hrithik Roshan & Alia Bhatt"],
                                                                                     ["id":2,
                                                                                      "choice":"Hrithik Roshan & Kiara Advani"],
                                                                                     ["id":3,
                                                                                      "choice":"Tiger Shroff & Vaani Kapoor"],
                                                                                     ["id":4,
                                                                                      "choice":"Hrithik Roshan & Vaani Kapoor"]]],
                                                                         ["id":2,
                                                                          "question":"Who sang this song \"Kaise Hua\" from the movie \"Kabir Singh\"?",
                                                                          "correctAnswer":2,
                                                                          "timerTime":30,
                                                                          "resourceURL": "audio2",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Amit Mishra"],
                                                                                     ["id":2,
                                                                                      "choice":"Vishal Mishra"],
                                                                                     ["id":3,
                                                                                      "choice":"Arijit Singh"],
                                                                                     ["id":4,
                                                                                      "choice":"Mithoon"]]],
                                                                         ["id":3,
                                                                          "question":"This song \"Bad Boy\" from the movie \"Saaho\" featured which singer & Bollywood Movie Star in a Guest Appearance?",
                                                                          "correctAnswer":1,
                                                                          "timerTime":20,
                                                                          "resourceURL": "audio3",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Baad Shah/ Jacqueline Fernandez"],
                                                                                     ["id":2,
                                                                                      "choice":"Baad Shah/ Deepika Padukone"],
                                                                                     ["id":3,
                                                                                      "choice":"Guru Randhawa/ Jacqueline Fernandez"],
                                                                                     ["id":4,
                                                                                      "choice":"Honey Singh/ Sara Ali Khan"]]],
                                                                         ["id":4,
                                                                          "question":"Who is the music director of this song?",
                                                                          "correctAnswer":2,
                                                                          "timerTime":20,
                                                                          "resourceURL": "audio4",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Vishal-Shekhar"],
                                                                                     ["id":2,
                                                                                      "choice":"Sachin-Jigar"],
                                                                                     ["id":3,
                                                                                      "choice":"Pritham"],
                                                                                     ["id":4,
                                                                                      "choice":"Armaan Malik"]]],
                                                                         ["id":5,
                                                                          "question":"From which movie is this song?",
                                                                          "correctAnswer":3,
                                                                          "timerTime":20,
                                                                          "resourceURL": "audio5",
                                                                          "choices":[["id":1,
                                                                                      "choice":"Sonu ke Titu ki Sweety"],
                                                                                     ["id":2,
                                                                                      "choice":"De de pyaar de"],
                                                                                     ["id":3,
                                                                                      "choice":"Luka Chuppi"],
                                                                                     ["id":4,
                                                                                      "choice":"Student of the year 2"]]]]
                ]])!
            let contest4 = QuizContest(JSON: ["id": 1,
                                              "title": "Video Quiz Game",
                                              "gameCard": ["id": 1,
                                                                                         "title": "video",
                                                                                         "noOfUsers": 1000,
                                                                                         "ticketPrice": 80,
                                                                                         "usersLeft": 243,
                                                                                         "numberOfQuestions": 30,
                                                                                         "minPlayers": 500,
                                                                                         "duration": "30-45 mins",
                                                                                         "prizePerQuestion":800,
                                                                                         "minPrizePerQuestion":400,
                                                                                         "questions": [["id":1,
                                                                                                        "question":"In the movie \"Panipat\", whom does Sanjay Dutt  refer to steal the Peacock Throne & Kohinoor?",
                                                                                                        "correctAnswer":1,
                                                                                                        "timerTime":40,
                                                                                                        "resourceURL": "video1",
                                                                                                        "choices":[["id":1,
                                                                                                                    "choice":"Nadir Shah"],
                                                                                                                   ["id":2,
                                                                                                                    "choice":"Ahmed Shah"],
                                                                                                                   ["id":3,
                                                                                                                    "choice":"Naved Shah"],
                                                                                                                   ["id":4,
                                                                                                                    "choice":"Nazir Shah"]]],
                                                                                                       ["id":2,
                                                                                                        "question":"In the movie \"Andhadun\", what is the color of the towel Ayushmann gives to Radhika Apte?",
                                                                                                        "correctAnswer":4,
                                                                                                        "timerTime":20,
                                                                                                        "resourceURL": "video2",
                                                                                                        "choices":[["id":1,
                                                                                                                    "choice":"Blue & Red"],
                                                                                                                   ["id":2,
                                                                                                                    "choice":"Black & Red"],
                                                                                                                   ["id":3,
                                                                                                                    "choice":"White & Green"],
                                                                                                                   ["id":4,
                                                                                                                    "choice":"White & Red"]]],
                                                                                                       ["id":3,
                                                                                                        "question":"In the movie \"Dangal\", which category completion  does the coach say Geetha won’t win a medal for India?",
                                                                                                        "correctAnswer":2,
                                                                                                        "timerTime":20,
                                                                                                        "resourceURL": "video3",
                                                                                                        "choices":[["id":1,
                                                                                                                    "choice":"50 kilos"],
                                                                                                                   ["id":2,
                                                                                                                    "choice":"55 kilos"],
                                                                                                                   ["id":3,
                                                                                                                    "choice":"45 kilos"],
                                                                                                                   ["id":4,
                                                                                                                    "choice":"40 kilos"]]],
                                                                                                       ["id":4,
                                                                                                        "question":"In the move \"Padman\", what does Akshay Kumar say he does?",
                                                                                                        "correctAnswer":1,
                                                                                                        "timerTime":20,
                                                                                                        "resourceURL": "video4",
                                                                                                        "choices":[["id":1,
                                                                                                                    "choice":"T&F: Try & Fail"],
                                                                                                                   ["id":2,
                                                                                                                    "choice":"D&F: Down & Fail"],
                                                                                                                   ["id":3,
                                                                                                                    "choice":"L&F: Learn & Fail"],
                                                                                                                   ["id":4,
                                                                                                                    "choice":"F&F: Fall & Fail"]]],
                                                                                                       ["id":5,
                                                                                                        "question":"In the movie \"Sanju\", on what subject has Anushka Sharma written a book on?",
                                                                                                        "correctAnswer":3,
                                                                                                        "timerTime":20,
                                                                                                        "resourceURL": "video5",
                                                                                                        "choices":[["id":1,
                                                                                                                    "choice":"Art"],
                                                                                                                   ["id":2,
                                                                                                                    "choice":"Temples"],
                                                                                                                   ["id":3,
                                                                                                                    "choice":"Museums"],
                                                                                                                   ["id":4,
                                                                                                                    "choice":"Spirituality"]]]]
                                              ]])!
            self.contests = [contest1, contest2, contest3, contest4]
            
        }
        
    }
