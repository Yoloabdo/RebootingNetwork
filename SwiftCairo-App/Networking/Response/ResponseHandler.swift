//
//  ResponseHandler.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

public typealias HandleResponse<T: CodableInit> = (Result<T>) -> Void


extension URLRequestBuilder {
    
    // MARK: - Response Handling
    func handleResponse(_ response: DataResponse<Data>, then: CallResponse<ResponseModel>){
        switch response.result {
        case .failure(let error):
            then?(Result<ResponseModel>.failure(error))
        case .success(let value):
            do {
                let modules = try ResponseModel(data: value)
                then?(Result<ResponseModel>.success(modules))
            }catch {
                then?(Result<ResponseModel>.failure(error))
            }
        }
    }
    
}
