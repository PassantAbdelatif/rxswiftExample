//
//  ControllerType.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 8/29/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

//All ViewController subclass objects in our app should conform to ControllerType protocol and define concrete type of view model, implement create(_:) and configure(with:) functions.
import UIKit
protocol ControllerType: class {
    associatedtype ViewModelType: ViewModelProtocol
    /// Configurates controller with specified ViewModelProtocol subclass
    ///
    /// - Parameter viewModel: CPViewModel subclass instance to configure with
    func configure(with viewModel: ViewModelType)
    /// Factory function for view controller instatiation
    ///
    /// - Parameter viewModel: View model object
    /// - Returns: View controller of concrete type
    static func create(with viewModel: ViewModelType) -> UIViewController
    
    func bindViews(with viewModel: ViewModelType)
}

extension ControllerType {
    func observeLoading(with viewModel: ViewModelType) {}
    func observeResult(with viewModel: ViewModelType)  {}
    func observeErrors(with viewModel: ViewModelType) {}
}
