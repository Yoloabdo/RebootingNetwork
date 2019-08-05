//
//  ResponseHandler.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

typealias HandleResponse<T: CodableInit> = (Result<T>) -> Void


protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, then: CallResponse<T>)
}

extension HandleAlamoResponse {
    
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, then: CallResponse<T>) {
        switch response.result {
        case .failure(let error):
            then?(Result<T>.failure(error))
        case .success(let value):
            do {
                let modules = try T(data: value)
                then?(Result<T>.success(modules))
            }catch {
                then?(Result<T>.failure(error))
            }
        }
    }
    
}
