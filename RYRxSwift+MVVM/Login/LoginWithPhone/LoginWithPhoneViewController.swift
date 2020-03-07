//
//  LoginWithPhoneViewController.swift
//  boss
//
//  Created by RyanYuan on 2019/12/2.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit
import RxCocoa
import NSObject_Rx

final class LoginWithPhoneViewController: BaseViewController {

    var viewModel: LoginWithPhoneViewModel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initVariables()
        initSubviews()
        bindViewModel()
    }
}

// MARK: private method
extension LoginWithPhoneViewController: ViewControllerInitProtocol {
    func initVariables() {
        
    }
    
    func initSubviews() {
        navigationController?.navigationBar.isHidden = true
    }

    func bindViewModel() {
        let input = LoginWithPhoneViewModel.Input.init(phoneText: phoneTextField.rx.text.orEmpty.asDriver(),
                                                       goBackTrigger: backButton.rx.tap.asDriver(),
                                                       nextStepTrigger: nextStepButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        output.phoneValid
            .drive(nextStepButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        output.updatePhoneText
            .drive(phoneTextField.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.goBack
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.nextStep
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
