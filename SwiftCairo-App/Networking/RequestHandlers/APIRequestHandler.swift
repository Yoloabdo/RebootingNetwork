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
    
    
}

extension APIRequestHandler where Self: URLRequestBuilder {

    func send<T: CodableInit>(_ decoder: T.Type, data: UploadData? = nil, progress: ((Progress) -> Void)? = nil, completion: CallResponse<T>) {
        if let data = data {
            uploadToServerWith(decoder, data: data, request: self, parameters: self.parameters, progress: progress, completion: completion)
        }else{
            request(self).validate().responseData {(response) in
                self.handleResponse(response, completion: completion)
            }
        }
    }
}


extension APIRequestHandler {
    
    private func uploadToServerWith<T: CodableInit>(_ decoder: T.Type, data: UploadData, request: URLRequestConvertible, parameters: Parameters?, progress: ((Progress) -> Void)?, completion: CallResponse<T>) {
        
        upload(multipartFormData: { (mul) in
            mul.append(data.data, withName: data.name, fileName: data.fileName, mimeType: data.mimeType)
            guard let parameters = parameters else { return }
            for (key, value) in parameters {
                mul.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: request) { (response) in
            switch response {
            case .success(let requestUp, _, _):
                requestUp.responseData(completionHandler: { (results) in
                    self.handleResponse(results, completion: completion)
                }).responseString(completionHandler: { (string) in
                    print(string.result.value)
                })
                
            case .failure(let error):
                completion?(ServerResponse<T>.failure(error as? LocalizedError))
            }
        }
    }
}






