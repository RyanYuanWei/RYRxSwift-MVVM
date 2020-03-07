//
//  LoginWithPhoneNavigator.swift
//  boss
//
//  Created by RyanYuan on 2019/12/30.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit

protocol LoginWithPhoneNavigator {
    func toLoginWithPhone()
    func toLoginWithCaptcha(_ phoneNumber: String)
    func goBack()
}

final class DefaultLoginWithPhoneNavigator: NSObject {
    private let lastViewController: UIViewController
    private var interiorNavController: UINavigationController?
    
    init(viewController: UIViewController) {
        self.lastViewController = viewController
    }
}

extension DefaultLoginWithPhoneNavigator: LoginWithPhoneNavigator {
    
    func toLoginWithPhone() {
        let viewModel = LoginWithPhoneViewModel.init(navigator: self)
        guard let viewController = R.storyboard.login.loginWithPhoneViewController() else { return }
        viewController.viewModel = viewModel
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.interiorNavController = navigationController
        lastViewController.present(navigationController, animated: true, completion: nil)
    }
    
    func toLoginWithCaptcha(_ phoneNumber: String) {
        let navigator = DefaultLoginWithCaptchaNavigator.init(navigationController: self.interiorNavController)
        let viewModel = LoginWithCaptchaViewModel.init(phoneNumber: phoneNumber, navigator: navigator)
        guard let captchaViewController = R.storyboard.login.loginWithCaptchaViewController() else { return }
        captchaViewController.viewModel = viewModel
        self.interiorNavController?.pushViewController(captchaViewController, animated: true)
    }
    
    func goBack() {
        self.interiorNavController?.dismiss(animated: true, completion: nil)
    }
}
