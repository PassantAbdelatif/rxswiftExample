//
//  AuthorizationApi.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/1/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import Moya

struct AuthorizationParamters {
    static let UserName = "user_name"
    static let Password = "password"
    static let DeviceToken = "device_token"
}

enum AuthorizationApi {
    case loginRequest(credentials: Credentials)
}
extension AuthorizationApi:TargetType , AccessTokenAuthorizable{
    
    var authorizationType: AuthorizationType {
        switch self {
        case .loginRequest(_):
            return .none
        }
    }
    
    var baseURL : URL {
        return URL(string:APPURL.BaseURL)!
    }
    var path: String {
        switch self {
        case .loginRequest(_):
            return  APPURL.Paths.LoginURl
        }
    }
    var method : Moya.Method {
        switch self {
        case .loginRequest  :
            return .post
        }
    }
    var task : Task {
        switch self {
        case .loginRequest(let credentials):
            return .requestParameters(parameters: [AuthorizationParamters.UserName: credentials.email,
                                                   AuthorizationParamters.Password: credentials.password,
                                                   AuthorizationParamters.DeviceToken: Key.DeviceType],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers : [String : String]? {
        return [Key.Headers.KEY_ContentType: Key.Headers.KEY_ContentTypeValue,
                Key.Headers.KEY_Encoding : Key.Headers.KEY_EncodingValue,
                Key.Headers.KEY_ApiName: Key.Headers.KEY_ApiValue,
                Key.Headers.KEY_LANG: "en"]
    }
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
