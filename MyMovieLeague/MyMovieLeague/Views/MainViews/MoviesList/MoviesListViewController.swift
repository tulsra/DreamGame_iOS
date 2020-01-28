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

        
        let menubutton = UIButton(type: .custom)
        menubutton.frame = CGRect(x: 0, y: 0, width: 18, height: 22)
        menubutton.setImage(UIImage(named: "menu"), for: .normal)
        menubutton.addTarget(self, action: #selector(menuBtnAction), for: .touchUpInside)
        
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
        
        self.tblView.register(UINib.init(nibName: cellReuseIdendifier, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier)
        
    }
    
    deinit {
        print("DEINIT MoviesListViewController")
    }
    
    
    @objc func menuBtnAction() {
        
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
            return (((UIScreen.main.bounds.size.width - 60)/2.0) * (3.0/2.0)) + 44
        }
        return (((UIScreen.main.bounds.size.width - 60)/2.0) * (3.0/2.0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! MovieTableViewCell
        
        if indexPath.section == 0 {
            cell.isCurrent = true
            cell.moviesList = ["Recent1","Recent2","Recent3","Recent4"]
        }
        if indexPath.section == 1 {
            cell.isCurrent = false
            cell.moviesList = ["Upcoming1","Upcoming2","Upcoming3","Upcoming4"]
        }
    
        cell.collView.reloadData()
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
        titleLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 24)
        
        if section == 0 {
            titleLabel.text = "Current games"
        }
        if section == 1 {
            titleLabel.text = "Upcoming games"
        }
        view.addSubview(titleLabel)
        return view
    }
    
    
    
}
