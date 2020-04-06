//
//  Movies.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper


class Movies: NSObject, Mappable, Codable {
    
    var currentMovies: [Movie]?
    var upComingMovies: [Movie]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        currentMovies <- map["currentMovies"]
        upComingMovies <- map["upComingMovies"]
    }
}
class Movie: NSObject, Mappable, Codable {
    
    var movieId: Int?
    var name: String?
    var movieUrl: String?
    var releaseDate: String?
    var releaseSeason: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        movieId <- map["movieId"]
        name <- map["name"]
        movieUrl <- map["movieUrl"]
        releaseDate <- map["releaseDate"]
        releaseSeason <- map["releaseSeason"]
    }
}
