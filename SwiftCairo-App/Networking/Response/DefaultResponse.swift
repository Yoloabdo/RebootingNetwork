//
//  DefaultResponse.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation

/// Default response to check for every request since this's how this api works. 
struct DefaultResponse: Codable, CodableInit {
    var status: Int
}
