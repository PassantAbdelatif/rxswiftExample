//
//  TextValidator.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/2/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import RxSwift

class TextValidator {
    var input: Observable<String>
    var regex: NSRegularExpression
    
    init(input: Observable<String>, regex: NSRegularExpression) {
        self.input = input
        self.regex = regex
    }
    
    func validate() -> Observable<Bool> {
        return input.map { text in
            //return true if regex matches the text
            return true
        }
    }
}
