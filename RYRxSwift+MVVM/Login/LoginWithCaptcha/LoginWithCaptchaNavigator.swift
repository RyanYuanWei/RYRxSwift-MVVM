//
//  LoginWithCaptchaNavigator.swift
//  boss
//
//  Created by RyanYuan on 2019/12/30.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit

protocol LoginWithCaptchaNavigator {
    func goBack()
    func endLogin()
}

final class DefaultLoginWithCaptchaNavigator: NSObject {
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension DefaultLoginWithCaptchaNavigator: LoginWithCaptchaNavigator {
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func endLogin() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
