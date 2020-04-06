//
//  GameCardViewModel.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
extension GameCardViewController {
    func getList() {
        self.showActivity()
        NetworkManager().get(method: Method.contest(movieId: self.movie?.movieId ?? 0), urlParam: ["api-version":"v1.0"], bodyParm: nil) { (response, error) in
            DispatchQueue.main.async {
                self.hideActivity()
                if let error = error {
                    self.view.makeToast(error, duration: 2.0, position: .center)
                }
                else {
                    self.contests = response as? [Contest] ?? [Contest]()
                    self.tblView.reloadData()
                }
            }
        }
    }
}
class GameCardViewModel {
    
   
}
