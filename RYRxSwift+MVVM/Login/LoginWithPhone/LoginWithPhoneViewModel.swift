//
//  LoginWithPhoneViewModel.swift
//  boss
//
//  Created by RyanYuan on 2019/12/2.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

final class LoginWithPhoneViewModel: BaseViewModel {
    private let navigator: LoginWithPhoneNavigator
    
    init(navigator: LoginWithPhoneNavigator) {
        self.navigator = navigator
    }
}

// MARK: ViewModelType
extension LoginWithPhoneViewModel: ViewModelType {
    struct Input {
        let phoneText: Driver<String>
        let goBackTrigger: Driver<Void>
        let nextStepTrigger: Driver<Void>
    }

    struct Output {
        let phoneValid: Driver<Bool>
        let updatePhoneText: Driver<String>
        let goBack: Driver<Void>
        let nextStep: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let rightPhoneLength = 11
        let phoneText = input.phoneText
        
        let phoneValid = phoneText
            .map {$0.count >= rightPhoneLength}

        let updatePhoneText = Driver.zip(phoneValid, phoneText, resultSelector: { (isValid, string) -> String in
            if isValid {
                let subString = string.prefix(rightPhoneLength)
                let reformedSubString = String(subString)
                return reformedSubString
            }
            return string
        })
        
        let goBack = input.goBackTrigger
            .do(onNext: navigator.goBack)
        
        let nextStep = input.nextStepTrigger
            .withLatestFrom(updatePhoneText)
            .do(onNext: {[unowned self] (phoneText) in
                self.navigator.toLoginWithCaptcha(phoneText)
            })
        
        return Output.init(phoneValid: phoneValid,
                           updatePhoneText: updatePhoneText,
                           goBack: goBack,
                           nextStep: nextStep)
    }
}
