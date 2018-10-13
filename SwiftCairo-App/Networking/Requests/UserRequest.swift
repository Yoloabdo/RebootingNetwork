//
//  ProjectRouter.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire


enum UserRouter: URLRequestBuilder {
    

    case login(email: String, password: String)
    case register(email: String, password: String, phone: String)
    case userProfile
    // MARK: - Path
    internal var path: String {
        switch self {
        case .login:
            return "user/login"
        case .register:
            return "register"
        case .userProfile:
            return "user"
        }
    }

    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        case let .login(email,password):
            params["email"] = email
            params["password"] = password
        case .register(let email, let password, let phone):
            params["email"] = email
            params["password"] = password
            params["phone"] = phone
        default: break
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .userProfile:
            return .get
        default:
            return .post
        }
    }
}



