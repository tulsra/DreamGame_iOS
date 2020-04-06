//
//  APIResponse.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation
import ObjectMapper

class VerifyPhoneNumber: NSObject, Mappable, Codable {
    
    var resend_token: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        resend_token <- map["resend_token"]
    }
}

class Token: NSObject, Mappable, Codable {
    
    var access_token: String?
    var token_type: String?
    var refresh_token: String?
    var scope: String?
    var userName: String?
    var isKycDone: String?
    var isProfileUpdated: String?
    var expires_in: Int?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        refresh_token <- map["refresh_token"]
        scope <- map["scope"]
        userName <- map["userName"]
        isKycDone <- map["isKycDone"]
        isProfileUpdated <- map["isProfileUpdated"]
        expires_in <- map["expires_in"]
    }
}


