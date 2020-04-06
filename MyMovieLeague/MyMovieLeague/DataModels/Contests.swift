//
//  Contests.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper


class Contest: NSObject, Mappable, Codable {
    
    var contestId: Int?
    var contestName: String?
    var contestPoolSize: Int?
    var remainingPoolSize: Int?
    var poolPrize: String?
    var timeLeft: String?
    var contestJoiningPrice: String?
    var firstPrizeAmount: String?
    var secondPrizeAmount: String?
    var thirdPrizeAmount: String?
    var winPercentage: String?
    var lstPoolPrizes: [PrizePool]?
    var lstMinPoolPrizes: [PrizePool]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        contestId <- map["contestId"]
        contestName <- map["contestName"]
        contestPoolSize <- map["contestPoolSize"]
        remainingPoolSize <- map["remainingPoolSize"]
        poolPrize <- map["poolPrize"]
        timeLeft <- map["timeLeft"]
        contestJoiningPrice <- map["contestJoiningPrice"]
        firstPrizeAmount <- map["firstPrizeAmount"]
        secondPrizeAmount <- map["secondPrizeAmount"]
        thirdPrizeAmount <- map["thirdPrizeAmount"]
        winPercentage <- map["winPercentage"]
        lstPoolPrizes <- map["lstPoolPrizes"]
        lstMinPoolPrizes <- map["lstMinPoolPrizes"]
    }
}
class PrizePool: NSObject, Mappable, Codable {
    
    var rId: Int?
    var rank: String?
    var winningAmount: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        rId <- map["rId"]
        rank <- map["rank"]
        winningAmount <- map["winningAmount"]
    }
}
