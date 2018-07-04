//
//  APIManager.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 1/29/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamoResponse {
    
    /// Calling network layer via (Alamofire), this implementation can be replaced anytime in one place which is the protocol itsel, applied everywhere.
    ///
    /// - Parameters:
    ///   - decoder: CodableInit confirmed class/struct, Model.type.
    /// - Returns: Promise.
    func send<T: CodableInit>(_ decoder: T.Type) -> Promise<T>
}

extension APIRequestHandler where Self: Alamofire.URLRequestConvertible {
    func send<T: CodableInit>(_ decoder: T.Type) -> Promise<T> {
        return request(self).validate().responseData().then { result in
            self.handleResponse(result.data)
        }
    }
}









