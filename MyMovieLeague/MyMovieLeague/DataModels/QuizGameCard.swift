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
    var numberOfQuestions: Int?
    var title: String?
    var minPlayers: Int?
    var duration: String?
    var prizePerQuestion:Int?
    var minPrizePerQuestion:Int?
    var questions:[Question]?
    
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
        minPlayers <- map["minPlayers"]
        duration <- map["duration"]
        prizePerQuestion <- map["prizePerQuestion"]
        minPrizePerQuestion <- map["minPrizePerQuestion"]
        questions <- map["questions"]
    }
}

class Question: NSObject, Mappable, Codable {
    
    var id: Int?
    var question: String?
    var choices: [Choice]?
    var correctAnswer:Int?
    var timerTime:Int?
    var resourceURL: String?

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        question <- map["question"]
        choices <- map["choices"]
        correctAnswer <- map["correctAnswer"]
        timerTime <- map["timerTime"]
        resourceURL <- map["resourceURL"]
    }
}

class Choice: NSObject, Mappable, Codable {
    
    var id: Int?
    var choice: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        choice <- map["choice"]
    }
}
