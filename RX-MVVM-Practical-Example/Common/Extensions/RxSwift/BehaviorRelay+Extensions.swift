//
//  BehaviorRelay+Extensions.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/4/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
}
