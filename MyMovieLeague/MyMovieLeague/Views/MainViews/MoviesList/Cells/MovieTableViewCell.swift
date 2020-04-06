//
//  MovieTableViewCell.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 26/01/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
class MovieTableViewCell: UITableViewCell {

      @IBOutlet weak var collView: UICollectionView!
    var moviesList:[Movie]?
    var isCurrent = true
    var cellTapped:(Movie)->Void = { (movie) in
           
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.collView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        let width = 200
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: 200)

        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collView.collectionViewLayout =  layout
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.delegate = self
        collView.dataSource = self
    }

}

extension MovieTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

        cell.imgBottomSpaceConstraint.constant = 0
        cell.btnPlayHeightConstraint.constant = 0
        if isCurrent {
            cell.imgBottomSpaceConstraint.constant = 4
            cell.btnPlayHeightConstraint.constant = 40
        }
        
        if let movie = self.moviesList?[indexPath.row] {
            cell.configure(movie: movie)
        }
            
         return cell
      }
      
      
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isCurrent {
        return CGSize(width: ((UIScreen.main.bounds.size.width - 60)/2.0), height: (((UIScreen.main.bounds.size.width - 60)/2.0) * (4.0/3.0)) + 44)
        }
        
         return CGSize(width: ((UIScreen.main.bounds.size.width - 60)/2.0), height: ((UIScreen.main.bounds.size.width - 60)/2.0) * (4.0/3.0))
        
      }

      // item spacing = vertical spacing in horizontal flow
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 20
      }

      // line spacing = horizontal spacing in horizontal flow
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 20
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = moviesList?[indexPath.row] {
            self.cellTapped(movie)
        }
    }
    
  }
