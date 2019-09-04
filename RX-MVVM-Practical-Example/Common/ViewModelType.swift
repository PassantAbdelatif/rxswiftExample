//
//  ViewModelType.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 8/29/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//


//On other side all view model objects should conform to ViewModelProtocol and define two associated types: Input and Output .

protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}
