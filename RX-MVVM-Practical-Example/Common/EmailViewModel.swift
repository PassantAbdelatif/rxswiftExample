//
//  EmailViewModel.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/4/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
// Data FieldViewModel : Email
struct  EmailViewModel: TextFieldType {
    
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    let title = "Email"
    let errorMessage = Key.ErrorMessage.emailNotValid
    let emptyMessage = Key.ErrorMessage.emailIsEmpty
    
    func validate() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        if !validateEmpty(value.value) { // validate it is not empty
            errorValue.accept(emptyMessage)
            return false
        } else if !validateString(value.value, pattern:emailPattern) { // validate it is valid
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
}
