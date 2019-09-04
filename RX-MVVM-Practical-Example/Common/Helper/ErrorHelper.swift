//
//  ErrorHelper.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/3/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

class ErrorHelper {
    static  func getErrorMessage(errorObj: ErrorResponse) -> String{
        var errorMessage = ""
        
        if let nameError = errorObj.name {
            errorMessage += "\n" + nameError
        }
        if let passwordError = errorObj.password {
            errorMessage += "\n" + passwordError
        }
        errorMessage = errorMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return errorMessage
    }
}
