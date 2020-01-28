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
          return 4
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

        if indexPath.row == 0 {
            cell.imgView.image = UIImage(named: "Recent1")
        }
        
        if indexPath.row == 1 {
            cell.imgView.image = UIImage(named: "Recent2")
        }
        if indexPath.row == 2 {
            cell.imgView.image = UIImage(named: "Recent3")
        }
        if indexPath.row == 3 {
            cell.imgView.image = UIImage(named: "Recent4")
        }
        
//         cell.backgroundColor = UIColor.green
         return cell
      }
      
      
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.size.width - 60)/2.0), height: ((UIScreen.main.bounds.size.width - 60)/2.0) * (3.0/2.0))
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
  }
