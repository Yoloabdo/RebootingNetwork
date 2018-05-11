//
//  CodableInit.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 3/28/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation

protocol CodableInit {
    init(data: Data) throws
}

extension CodableInit where Self: Codable {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self = try decoder.decode(Self.self, from: data)
    }
}

