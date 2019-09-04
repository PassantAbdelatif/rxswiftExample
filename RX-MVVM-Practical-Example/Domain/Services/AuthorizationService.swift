//
//  LoginService.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/1/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import RxSwift
import Moya
import Moya_ObjectMapper
class AuthorizationService : LoginServiceProtocol {
    func signIn(credentials: Credentials) -> Observable<LoginResponse> {
        return Observable.create { observer in
             //Networking logic here.
            let provider = MoyaProvider<AuthorizationApi>()
            provider.rx.request(.loginRequest(credentials: credentials))
                .mapObject(LoginResponse.self)
                .subscribe { event in
                switch event {
                case .success(let response):
                // do something with the data
                    observer.onNext(response)
                case .error(let error):
                    // handle the error
                    observer.onError(error)
                }
            }
            ///////
             return Disposables.create()
        }
    }
}
