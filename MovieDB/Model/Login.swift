//
//  Login.swift
//  MovieDB
//
//  Created by Hasan Dag on 18.07.2021.
//

import Foundation

struct sessionId : Codable {
    var request_token, session_id : String?
    var request_success, session_success:Bool?

    
}

struct UserData {
    var username:String
    var password:String
    var request_token: String
    var session_id:String
    var request_success, session_success:Bool

}
