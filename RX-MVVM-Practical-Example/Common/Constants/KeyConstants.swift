//
//  KeyConstants.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/1/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

struct Key {
    
    static let DeviceType = "iOS"
    
    // MARK: UserDefaults
    
    struct UserDefaults {
        static let k_App_Running_FirstTime = "userRunningAppFirstTime"
    }
    
    // MARK: Headers Values
    
    struct Headers {
        static let KEY_ApiName = "X-Api-Key"
        static let KEY_ApiValue = "55axvd80c2jxp31y"
        static let KEY_LANG = "Accept-Language"
        static let KEY_Authorization = "Authorization"
        static let KEY_ContentType = "Content-type"
        static let KEY_ContentTypeValue = "application/json"
        static let KEY_Encoding = "Accept-Encoding"
        static let KEY_EncodingValue = "application/json"
    }
    
    // MARK: Google Keys
    
    struct Google {
        static let placesKey = "some key here"//for photos
        static let serverKey = "some key here"
    }
    
    // MARK: Error Messages
    
    struct ErrorMessage {
        static let listNotFound = "ERROR_LIST_NOT_FOUND"
        static let validationError = "ERROR_VALIDATION"
        static let emailIsEmpty = "please enter your email"
        static let emailNotValid = "Email is not valid"
        static let passwordIsEmpty = "please enter your password"
        static let passwordNotValid = "password should be equal or more than eight character"
    }
}
