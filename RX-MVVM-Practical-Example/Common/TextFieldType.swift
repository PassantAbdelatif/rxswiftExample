//
//  TextFieldType.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/3/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import RxSwift
import RxCocoa
protocol TextFieldType {
    var title: String { get}
    var errorMessage: String { get }
    
    // Observables
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get}
    
    // Validation
    func validate() -> Bool
}

extension TextFieldType {
    func validateSize(_ value: String,
                      size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?,
                        pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
    func validateEmpty(_ value: String) -> Bool {
        return !value.isBlank
    }
}
