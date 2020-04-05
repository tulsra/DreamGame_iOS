//
//  NetworkReponse.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 4/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func obj(JSONString: String) -> Any?  {
        switch self.method {
        case .verifyPhoneNumber:
            if let obj = VerifyPhoneNumber(JSONString: JSONString) {
                return obj
            }
        case .verifyToken:
            if let obj = Token(JSONString: JSONString) {
                return obj
            }
        default:
            return nil
        }
        return nil
    }
    
}


