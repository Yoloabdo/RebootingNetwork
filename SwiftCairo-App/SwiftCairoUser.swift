//
//  SwiftCairoUser.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 5/9/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//


import Foundation

struct SwiftCairoUser: Codable, CodableInit {
    let status: Int?
    let userStatus, apiToken, name: String?
    let age: Int?
    let maritalStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case userStatus = "user_status"
        case apiToken = "api_token"
        case name, age
        case maritalStatus = "marital_status"
    }
}



