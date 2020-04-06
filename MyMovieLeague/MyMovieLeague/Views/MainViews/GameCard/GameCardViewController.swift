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
    let viewModel = GameCardViewModel()
    var movie:Movie?
    var contests:[Contest] = [Contest]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        getList()
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
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! GameCardTableViewCell
        cell.selectionStyle = .none
         let contest = self.contests[indexPath.section]
        cell.lblTotalPrize.text = contest.poolPrize?.indianString?.currencyStamped ?? ""
            cell.lblEntryFee.text = contest.contestJoiningPrice?.currencyStamped ?? ""

            cell.lblFirstPrize.text = contest.firstPrizeAmount?.indianString?.currencyStamped ?? ""
            cell.lblSecondPrize.text = contest.secondPrizeAmount?.indianString?.currencyStamped ?? ""
            cell.lblThirdPrize.text = contest.thirdPrizeAmount?.indianString?.currencyStamped ?? ""

            cell.lblLeftSpots.text = "\(contest.remainingPoolSize?.indianString ?? "") Players Left"
            cell.lblTotalSpots.text = "\(contest.contestPoolSize?.indianString ?? "") Players"
        cell.lblMinPlayers.text = "Minimum: 20,000 Players"//"Minimum: \(contest.minPlayers?.indianString ?? "") Players"
        cell.tag = indexPath.section
        cell.completionHandler = { tag in
            if let movie = self.movie {
                let moviesListVC = PlayGameViewController()
                moviesListVC.contest = self.contests[tag]
                moviesListVC.movie = movie
                self.navigationController?.pushViewController(moviesListVC, animated: true)
            }
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
        
        titleLabel.text = self.contests[section].contestName?.uppercased()
        
        view.addSubview(titleLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
                
        let moviesListVC = PrizeBreakupViewController()
        moviesListVC.contest = self.contests[indexPath.section]
        moviesListVC.movie = self.movie
        self.navigationController?.pushViewController(moviesListVC, animated: true)
 
    }
}


extension GameCardViewController {

    
}
