//
//  ResponseHandler.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire


protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>)
}

extension HandleAlamoResponse {
    
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
        if let error = response.error {
            // handle errors
            completion?(ServerResponse<T>.failure(error as? LocalizedError))
            print(error.localizedDescription)
            return
        }
        guard let data = response.result.value else {
            completion?(ServerResponse<T>.failure(response.error as? LocalizedError))
            print(response.error?.localizedDescription ?? "serverResponse returned with failure condition")

            return
        }
        do {
            let response = try DefaultResponse(data: data)
            if response.status == 1 {
                let modules = try T(data: data)
                completion?(ServerResponse<T>.success(modules))
            }else{
                completion?(ServerResponse<T>.failure(APIError(rawValue: response.status)))
                print(APIError(rawValue: response.status) ?? "Unknown error")
            }
        }catch {
            completion?(ServerResponse<T>.failure(error as? LocalizedError))
        }
    }
}
