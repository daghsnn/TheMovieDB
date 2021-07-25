//
//  Login.swift
//  MovieDB
//
//  Created by Hasan Dag on 18.07.2021.
//

import Foundation


struct requestToken : Codable {
    var success:Bool
    var request_token:String
}
struct requestSession : Codable {
    var success:Bool
    var session_id:String
}

    
struct accountModel : Codable {
    let id: Int?
    let includeAdult: Bool?
    let username: String?
}
