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
typealias CallResponse<T> = ((Result<T>) -> Void)?


/// API protocol, The alamofire wrapper
protocol APIRequestHandler {
    
}

extension APIRequestHandler where Self: URLRequestBuilder {

    func send(then: CallResponse<ResponseModel>) {
        request(self).validate().responseData {(response) in
            self.handleResponse(response, then: then)
            }.responseJSON { (response) in
                // handle debug
                print(response.result.value)
        }
    }
    
    func cancelRequest() -> Void {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            uploadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            downloadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
        }
    }
}





