//
//  MoviesListViewModel.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation

extension MoviesListViewController {
    func getList() {
        self.showActivity()
        NetworkManager().get(method: .movie, urlParam: ["api-version":"v1.0"], bodyParm: nil) { (response, error) in
            DispatchQueue.main.async {
                self.hideActivity()
                if let error = error {
                    self.view.makeToast(error, duration: 2.0, position: .center)
                }
                else {
                    self.movies = response as? Movies
                    self.tblView.reloadData()
                }
            }
        }
    }
}
class MoviesListViewModel {
    
   
}
