//
//  ServerResponse.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation

/// Response enum, to make the results completion handler better, instead of:
/// (Any?) -> Void
/// (Any?, Error?) -> Void
/// to: (response) -> Void
///
/// - success: Request has been gracefully handled with (Codable object).
/// - failure: Current request failed, with the localized error.
enum ServerResponse<T> {
    case success(T), failure(LocalizedError?)
}
