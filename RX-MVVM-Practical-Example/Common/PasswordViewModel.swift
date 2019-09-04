//
//  PasswordViewModel.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/4/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
struct PasswordViewModel : TextFieldType, SecureFieldViewModel {
    var isSecureTextEntry: Bool = true
    
    
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    let title = "Password"
    let errorMessage = Key.ErrorMessage.passwordNotValid
    let emptyMessage = Key.ErrorMessage.passwordIsEmpty
    
    
    func validate() -> Bool {
        if !validateEmpty(value.value) { // validate it is not empty
            errorValue.accept(emptyMessage)
            return false
        } else if !validateSize(value.value, size: (8,25)) { // between 8 and 25 caracters
            errorValue.accept(errorMessage)
            return false
        }

        errorValue.accept(nil)
        return true
    }
}

// Options for FieldViewModel
protocol SecureFieldViewModel {
    var isSecureTextEntry: Bool { get }
}
