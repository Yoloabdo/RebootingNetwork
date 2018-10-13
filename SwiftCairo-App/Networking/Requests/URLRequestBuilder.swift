//
//  RequestBuilderProtocol.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: String { get }
    var headers: HTTPHeaders? { get }

    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
}


extension URLRequestBuilder {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var mainURL: URL  {
        return URL(string: "https://live.mysite.com")!
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var headers: HTTPHeaders? {
        if let token = UserDefaults.standard.string(forKey: "Token"){
            return ["token": token]
        }else{
            return nil
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        return request
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
