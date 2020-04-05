//
//  GamePlayCard.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 27/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper

class GamePlayCard: NSObject, Mappable, Codable {
    
    var id: Int?
    var movieTitle: String?
    var movieGenre: String?
    var releaseDate: String?
    var releaseTime: String?
    var movieImageURL:String?
    var contestTitle: String?
    var ticketPrice: Int?
    var predictometerValue:Double?
    var numberOfEntries:Int?
    var extepectedRanges: [String]?
    var stars: [Star]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        movieTitle <- map["movieTitle"]
        movieGenre <- map["movieGenre"]
        releaseDate <- map["releaseDate"]
        releaseTime <- map["releaseTime"]
        movieImageURL <- map["movieImageURL"]
        contestTitle <- map["contestTitle"]
        ticketPrice <- map["ticketPrice"]
        predictometerValue <- map["predictometerValue"]
        numberOfEntries <- map["numberOfEntries"]
        extepectedRanges <- map["extepectedRanges"]
        stars <- map["stars"]
    }
}

class ExpectedRange: NSObject, Mappable, Codable {
    
    var id: Int?
    var range: String?
  
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        range <- map["range"]
    }
}

class Star: NSObject, Mappable, Codable {
    
    var id: Int?
    var name: String?
    var imageUrl:String?
    var role: String?
    var recentHistoy: [RecentHistory]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        role <- map["role"]
        imageUrl <- map["imageUrl"]
        recentHistoy <- map["recentHistoy"]
    }
}

class RecentHistory: NSObject, Mappable, Codable {
    
    var id: Int?
    var movieTitle: String?
    var movieGenre: String?
    var verdict: String?
    var imageUrl:String?
    var collection:[String]?
  
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        movieTitle <- map["movieTitle"]
        movieGenre <- map["movieGenre"]
        verdict <- map["verdict"]
        imageUrl <- map["imageUrl"]
        collection <- map["collection"]
    }
}
