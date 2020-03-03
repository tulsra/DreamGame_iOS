//
//  GameCard.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 07/02/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper

class Contest: NSObject, Mappable, Codable {
    
    var id: Int?
    var title: String?
    var movieTitle:String?
    var movieGenre: String?
    var releaseDate: String?
    var releaseTime: String?
    var movieImageURL:String?
    var extepectedRanges: [String]?
    var stars:[Star]?
    var gameCard: GameCard?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        movieTitle <- map["movieTitle"]
        movieGenre <- map["movieGenre"]
        releaseDate <- map["releaseDate"]
        releaseTime <- map["releaseTime"]
        movieImageURL <- map["movieImageURL"]
        extepectedRanges <- map["extepectedRanges"]
        stars <- map["stars"]
        gameCard <- map["gameCard"]
    }
}

class GameCard: NSObject, Mappable, Codable {
    
    var id: Int?
    var noOfUsers: Int?
    var ticketPrice: Int?
    var usersLeft: Int?
    var prizePool: String?
    var firstPrize:Int?
    var secondPrize:Int?
    var thirdPrize:Int?
    var title: String?
    var prizeBreakup: [PrizeBreakup]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        noOfUsers <- map["noOfUsers"]
        ticketPrice <- map["ticketPrice"]
        usersLeft <- map["usersLeft"]
        prizePool <- map["prizePool"]
        title <- map["title"]
        prizeBreakup <- map["prizeBreakup"]
        firstPrize <- map["firstPrize"]
        secondPrize <- map["secondPrize"]
        thirdPrize <- map["thirdPrize"]
    }
}
class PrizeBreakup: NSObject, Mappable, Codable {
    
    var id: Int?
    var order: Int?
    var rankFrom: Int?
    var rankTo: Int?
    var amount: Int?

    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        order <- map["order"]
        rankFrom <- map["rankFrom"]
        rankTo <- map["rankTo"]
        amount <- map["amount"]
    }
    
    func getRankString()->String {
        if rankFrom == rankTo {
            return "#Rank \(rankFrom ?? 0)"
        }
        return "#Rank \(rankFrom ?? 0) To \(rankTo ?? 0)"
    }
}


