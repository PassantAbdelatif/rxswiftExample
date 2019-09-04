//
//  LoginViewController.swift
//  RX-MVVM-Practical-Example
//
//  Created by Bassant Khaled on 8/29/19.
//  Copyright © 2019 Bassant Khaled. All rights reserved.
//

import UIKit
import RxSwift
import TransitionButton
import RxCocoa
class LoginViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var signInButton: TransitionButton!
    
    // MARK: - Properties
    typealias ViewModelType = LoginControllerViewModel
    private var viewModel: ViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(with: viewModel)
    }
    
}

extension LoginViewController: ControllerType {
    func configure(with viewModel: LoginControllerViewModel) {
        bindViews(with: viewModel)
        observeLoading(with: viewModel)
        observeResult(with: viewModel)
        observeErrors(with: viewModel)
    }
    
    
    func bindViews(with viewModel: LoginControllerViewModel) {
        //////inputs
        emailTextField.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { text in
                print("editing state changed\(text)")
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        passwordTextField.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
        signInButton.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        
    }
    func observeLoading(with viewModel: LoginControllerViewModel) {
        viewModel.output.loadingObservable
            .subscribe(onNext:{ (loading) in
            if loading == true {
                self.signInButton.startAnimation()
            } else {
                self.signInButton.stopAnimation()
            }
        }).disposed(by: disposeBag)
    }
    func observeResult(with viewModel: LoginControllerViewModel) {
        viewModel.output.requestResultObservable
            .subscribe(onNext:{ response in
            // self.performSegue(withIdentifier:"NewsViewController", sender: nil)
            self.presentMessage("sucessfully logged in")
        }).disposed(by: disposeBag)
    }
    func observeErrors(with viewModel: LoginControllerViewModel) {
        viewModel.output.validationErrorObservable
            .subscribe(onNext:{ isValid in
                self.emailValidationLabel.text = viewModel.emailFieldViewModel.errorValue.value ?? ""
                self.passwordValidationLabel.text = viewModel.passwordFieldViewModel.errorValue.value ?? ""
            }).disposed(by: disposeBag)
        
        viewModel.output.serverErrorObservable
            .subscribe(onNext:{ error in
                self.presentMessage(error)
            }).disposed(by: disposeBag)
        
    }
}

extension LoginViewController {
    static func create(with viewModel: ViewModelType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        controller.viewModel = viewModel
        return controller
    }

}
