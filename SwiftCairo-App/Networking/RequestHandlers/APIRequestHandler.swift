//
//  APIManager.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 1/29/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire



/// Response completion handler beautified.
typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?


/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamoResponse {
    
    /// Calling network layer via (Alamofire), this implementation can be replaced anytime in one place which is the protocol itsel, applied everywhere.
    ///
    /// - Parameters:
    ///   - decoder: Codable confirmed class/struct, Model.type.
    ///   - completion: Results of the request, general errors cases handled.
    /// - Returns: Void.
    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>)
}

extension APIRequestHandler where Self: URLRequestConvertible {

    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>) {
        request(self).validate().responseData {(response) in
            self.handleResponse(response, completion: completion)
        }
    }
}








