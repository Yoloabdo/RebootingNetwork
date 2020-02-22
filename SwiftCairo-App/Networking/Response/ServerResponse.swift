//
//  ServerResponse.swift
//  SwiftCairo-App
//
//  Created by Mohammed Elnaggar on 2/22/20.
//  Copyright © 2020 abdelrahman mohamed. All rights reserved.
//

import Foundation

enum ServerResponse<T> {
    case success(T), failure(Error)
}
