//
//  AlamofireResponse.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 5/9/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Alamofire

// MARK: - This extension I spotted in the Quicktype site, so I gave it a look and I don't think it's so good anyway, due to error handling, not so good. so just here for demonstraition.
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    
    @discardableResult
    /// Generalized version of the original function
    ///
    /// - Parameters:
    ///   - dumb: Codable model.
    ///   - queue: not necessary.
    ///   - completionHandler: response with object in value, errors otherwise.
    /// - Returns: returns the request, but ignore that. 
    func response<T: Decodable>(_ dumb: T.Type, queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    func responseSwiftCairoUser(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SwiftCairoUser>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

