//
//  QuizGameCard.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 02/03/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper

class QuizContest: NSObject, Mappable, Codable {
    
    var id: Int?
    var title: String?
    var timerTime: String?
    var gameCard: QuizGameCard?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        timerTime <- map["timerTime"]
        gameCard <- map["gameCard"]
    }
}

class QuizGameCard: NSObject, Mappable, Codable {
    
    var id: Int?
    var noOfUsers: Int?
    var ticketPrice: Int?
    var usersLeft: Int?
    var numberOfQuestions: String?
    var title: String?
    
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
        numberOfQuestions <- map["numberOfQuestions"]
        title <- map["title"]
    }
}
