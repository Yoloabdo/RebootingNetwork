//
//  ResponseHandler.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - Return: Promise with Data into the generic Module
    func handleResponse<T: CodableInit>(_ response: Data) -> Promise<T>
}

extension HandleAlamoResponse {
    
    func handleResponse<T: CodableInit>(_ response: Data) -> Promise<T> {
        
        return Promise<T> { promise in
            do {
                let modules = try T(data: response)
                promise.fulfill(modules)
            }catch {
                promise.reject(error)
            }
        }
    }
}

