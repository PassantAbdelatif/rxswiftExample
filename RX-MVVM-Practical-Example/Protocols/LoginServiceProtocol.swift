//
//  LoginServiceProtocol.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/1/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import RxSwift

protocol LoginServiceProtocol {
    func signIn(credentials: Credentials) -> Observable<LoginResponse>
}
