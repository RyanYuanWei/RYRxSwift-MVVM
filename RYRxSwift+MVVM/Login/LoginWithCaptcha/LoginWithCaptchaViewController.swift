//
//  LoginWithCaptchaViewController.swift
//  boss
//
//  Created by RyanYuan on 2019/12/2.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

final class LoginWithCaptchaViewController: BaseViewController {

    var viewModel: LoginWithCaptchaViewModel!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var captchaTextField: UITextField!
    @IBOutlet weak var getCaptchaButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initVariables()
        initSubviews()
        bindViewModel()
    }
}

// MARK: private method
extension LoginWithCaptchaViewController: ViewControllerInitProtocol {
    func initVariables() {

    }

    func initSubviews() {
        self.tipsLabel.text = String.init(format: "我们向+86 %@发送了一个验证码，请在下方输入", viewModel.phoneNumber ?? "")
    }

    func bindViewModel() {
        
        let input = LoginWithCaptchaViewModel.Input
            .init(captchaTrigger: getCaptchaButton.rx.tap.asDriver(),
                  captchaText: captchaTextField.rx.text.orEmpty.asDriver(),
                  loginTrigger: loginButton.rx.tap.asDriver(),
                  goBackTrigger: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        output.captchaButtonEnable
            .drive(getCaptchaButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        output.captchaButtonTitle
            .drive(getCaptchaButton.rx.title(for: .normal))
            .disposed(by: rx.disposeBag)
        output.captchaValid
            .drive(loginButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        output.refomedCaptchaText
            .drive(captchaTextField.rx.text)
            .disposed(by: rx.disposeBag)
        output.errorMessage
            .drive(onNext: {[unowned self] (errorMessage) in
                let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
        output.loginSuccess
            .drive()
            .disposed(by: rx.disposeBag)
        output.goBack
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
