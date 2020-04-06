//
//  PlayGameViewModel.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/6/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
extension PlayGameViewController {
    func getList() {
        self.showActivity()
        
        NetworkManager().get(method: Method.movieContestDetails(movieId: self.movie?.movieId ?? 0, contestId: self.contest?.contestId ?? 0), urlParam: ["api-version":"v1.0"], bodyParm: nil) { (response, error) in
            DispatchQueue.main.async {
                self.hideActivity()
                if let error = error {
                    self.view.makeToast(error, duration: 2.0, position: .center)
                }
                else {
                    self.contestDetails = response as? ContestDetails
                    self.recentBoxoffice =  self.contestDetails?.lstRecentBoxOffice
                    if let lst = self.contestDetails?.lstCast, lst.count > 0 {
                        self.cast = self.contestDetails?.lstCast?.first
                    }
                    self.loadData()
                }
            }
        }
    }
    func getRecentBoxoffice(castId:Int) {
        self.showActivity()
        
        NetworkManager().get(method: Method.getrecentboxoffice(contestId: self.contest?.contestId ?? 0, castId: castId ), urlParam: ["api-version":"v1.0"], bodyParm: nil) { (response, error) in
            DispatchQueue.main.async {
                self.hideActivity()
                if let error = error {
                    self.view.makeToast(error, duration: 2.0, position: .center)
                }
                else {
                    self.recentBoxoffice = response as? [RecentBoxOffice]
                    self.loadData()
                }
            }
        }
    }
}
class PlayGameViewModel {
    
   
}
