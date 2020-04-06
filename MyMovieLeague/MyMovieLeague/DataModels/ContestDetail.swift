//
//  ContestDetail.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/6/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper

class ContestDetails: NSObject, Mappable, Codable {
    
    var contestId: Int?
    var movieId: Int?
    var contestName: String?
    var movieDetail: MovieDetail?
    var lstCast: [Cast]?
    var lstRecentBoxOffice:[RecentBoxOffice]?
    var userJoinedDetails: String?
    var lstExpectedRange: [ExpectedRange]?
    var meterDetail:MeterDetail?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        contestId <- map["contestId"]
        movieId <- map["movieId"]
        contestName <- map["contestName"]
        movieDetail <- map["movieDetail"]
        lstCast <- map["lstCast"]
        lstRecentBoxOffice <- map["lstRecentBoxOffice"]
        userJoinedDetails <- map["userJoinedDetails"]
        lstExpectedRange <- map["lstExpectedRange"]
        meterDetail <- map["meterDetail"]
    }
}

class MovieDetail: NSObject, Mappable, Codable {
    
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

class Cast: NSObject, Mappable, Codable {
    
    var castId: Int?
    var name: String?
    var castRole:String?
    var castImgUrl: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        castId <- map["castId"]
        name <- map["name"]
        castImgUrl <- map["castImgUrl"]
        castRole <- map["castRole"]
    }
}

class RecentBoxOffice: NSObject, Mappable, Codable {
    
    var movieName: String?
    var movieUrl: String?
    var totalCollection: String?
    var genre: String?
    var movieResult:String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        movieName <- map["movieName"]
        movieUrl <- map["movieUrl"]
        totalCollection <- map["totalCollection"]
        genre <- map["genre"]
        movieResult <- map["movieResult"]
    }
}

class ExpectedRange: NSObject, Mappable, Codable {
    
    var rangeFrom: Double?
    var rangeTo: Double?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        rangeFrom <- map["rangeFrom"]
        rangeTo <- map["rangeTo"]
    }
}


class MeterDetail: NSObject, Mappable, Codable {
    
    var start: Double?
    var current: Double?
    var end:Double?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        start <- map["start"]
        current <- map["current"]
        end <- map["end"]
    }
}
