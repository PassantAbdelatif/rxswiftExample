//
//  LoginViewModel.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 9/1/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import Foundation
import RxSwift

class LoginControllerViewModel: ViewModelProtocol {
    
    // MARK: - Public properties
    let input: Input
    let output: Output
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    
    struct Output {
        let loadingObservable: Observable<Bool>
        let requestResultObservable: Observable<User>
        let serverErrorObservable: Observable<String>
        let validationErrorObservable: Observable<Bool>
    }
    
    // MARK: - Private properties
    private let emailSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let loadingSubject = PublishSubject<Bool>()
    private let requestResultSubject = PublishSubject<User>()
    private let validationErrorSubject = PublishSubject<Bool>()
    private let serverErrorSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    let emailFieldViewModel = EmailViewModel()
    let passwordFieldViewModel = PasswordViewModel()
    
    private var credentialsObservable: Observable<Credentials> {
        //combineLatest simply combines multiple sources and emits any time there’s a new value from any of them.
        
        //As we can see, any time there’s a new event from any of the sources we get the latest values from all sources. It’s up to us to define how the values should be combined. For example we could wrap the values in a Pair, or a custom object like the Credentials.
        return Observable.combineLatest(emailSubject.asObservable(),
                                        passwordSubject.asObservable())
        { (email, password) in
            return Credentials(email: email,
                               password: password)
        }
    }
    
    func validForm() -> Bool {
        let isValidEmail = emailFieldViewModel.validate()
        let isValidPassword = passwordFieldViewModel.validate()
        self.validationErrorSubject.onNext(isValidEmail && isValidPassword)
        return isValidEmail && isValidPassword
    }
    
    // MARK: - Init and deinit
    init(_ loginService: LoginServiceProtocol) {
        input = Input(email: emailSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        output = Output(loadingObservable: loadingSubject.asObservable(),
                        requestResultObservable: requestResultSubject.asObservable(),
                        serverErrorObservable: serverErrorSubject.asObservable(),
                        validationErrorObservable: validationErrorSubject.asObservable())
        
        signInDidTapSubject
            //to validate the Credentials. We can use withLatestFrom to achieve this
            .withLatestFrom(credentialsObservable)
            .filter { credentials in
                self.emailFieldViewModel.value.accept(credentials.email)
                self.passwordFieldViewModel.value.accept(credentials.password)
                return self.validForm()
            }
            .do(onNext: { _ in
                self.loadingSubject.onNext(true)
            })
            .flatMapLatest { credentials in
                return loginService.signIn(credentials: credentials).materialize()
                // materialize() returns: An observable sequence that wraps events in an Event<E>. The returned Observable never errors, but it does complete after observing all of the events of the underlying Observable.
                
            }
            .subscribe(onNext: { [weak self] event in
                self?.loadingSubject.onNext(false)
                // Do something with the API call result
                switch event {
                case .next(let data):
                    if let user = data.user {
                        self?.requestResultSubject.onNext(user)
                    } else {
                        var errorMsg = ""
                        if let errors = data.errors {
                            errorMsg = ErrorHelper.getErrorMessage(errorObj: errors)
                        } else if let errorMessage = data.message {
                            errorMsg = errorMessage
                        }
                        self?.serverErrorSubject.onNext(errorMsg)
                    }
                case .error(let error):
                    self?.serverErrorSubject.onNext(error.localizedDescription)
                default:
                    break
                }
                
            })
            .disposed(by: disposeBag)
    }
  
}
