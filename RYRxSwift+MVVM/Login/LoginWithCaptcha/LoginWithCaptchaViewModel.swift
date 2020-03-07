//
//  LoginWithCaptchaViewModel.swift
//  boss
//
//  Created by RyanYuan on 2019/12/3.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

final class LoginWithCaptchaViewModel: BaseViewModel {
    private let navigator: LoginWithCaptchaNavigator
    let phoneNumber: String?
    
    init(phoneNumber: String?,
         navigator: LoginWithCaptchaNavigator) {
        self.phoneNumber = phoneNumber
        self.navigator = navigator
    }
}

// MARK: ViewModelType
extension LoginWithCaptchaViewModel: ViewModelType {
    struct Input {
        let captchaTrigger: Driver<Void>
        let captchaText: Driver<String>
        let loginTrigger: Driver<Void>
        let goBackTrigger: Driver<Void>
    }
    
    struct Output {
        let captchaButtonEnable: Driver<Bool>
        let captchaButtonTitle: Driver<String>
        let captchaValid: Driver<Bool>
        let refomedCaptchaText: Driver<String>
        let errorMessage: Driver<String>
        let loginSuccess: Driver<Void>
        let goBack: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        // 1.获取验证码
        let starCount = 1, endCount = 10
        
        let getCaptchaResult = input.captchaTrigger
            .flatMap {
                // 模拟请求
                Driver.just(true)
            }
            .filter { $0 }
        
        let counterSwitch = PublishSubject<Bool>()
        getCaptchaResult
            .drive(counterSwitch)
            .disposed(by: rx.disposeBag)
            
        let timer = Observable<Int>.interval(.milliseconds(1000), scheduler: MainScheduler.instance)
        let counter = timer
            .withLatestFrom(counterSwitch, resultSelector: { (_, isRunning) -> Bool in
                return isRunning
            })
            .filter { $0 }
            .scan(0, accumulator: {(aggregateValue, _) in
                if aggregateValue == endCount {
                    return starCount
                }
                return aggregateValue + 1
            })
            .asDriver(onErrorJustReturn: 0)

        let captchaButtonEnable = counter
            .flatMap { (count) -> Driver<Bool> in
                if count == endCount {
                    return Driver.just(true)
                }
                return Driver.just(false)
            }
        
        let captchaButtonTitle = counter
            .flatMap { (count) -> Driver<String> in
                var title = ""
                if count == endCount {
                    title = "获取验证码"
                } else {
                    title = String.init(format: "%ldS", count)
                }
                return Driver.just(title)
            }
        
        counter
            .drive(onNext: { (count) in
                if count == endCount {
                    counterSwitch.onNext(false)
                }
            })
            .disposed(by: rx.disposeBag)
        
        // 2.输入验证码
        let minCaptchaLength = 4
        let maxCaptchaLength = 8
        let captchaValid = input.captchaText
            .map {$0.count >= minCaptchaLength}
        let refomedCaptchaText = Driver.combineLatest(captchaValid, input.captchaText) { (isValid, text) -> String in
            var refomedText = text
            if isValid {
                let subString = text.prefix(maxCaptchaLength)
                refomedText = String(subString)
            }
            return refomedText
        }
        
        // 3.登陆
        let loginResult = input.loginTrigger
            .flatMap {
                // 模拟请求
                return Driver.just(true)
            }
        
        let errorMessage = loginResult
            .filter { !$0 }
            .flatMapLatest { _ in
                Driver.just("获取验证码失败")
            }
        
        let loginSuccess = loginResult
            .filter { $0 }
            .flatMapLatest { _ in
                Driver.just(Void())
            }
            .do(onNext: navigator.endLogin)
        
        let goBack = input.goBackTrigger
            .do(onNext: navigator.goBack)
        
        let output = Output.init(captchaButtonEnable: captchaButtonEnable,
                                 captchaButtonTitle: captchaButtonTitle,
                                 captchaValid: captchaValid,
                                 refomedCaptchaText: refomedCaptchaText,
                                 errorMessage: errorMessage,
                                 loginSuccess: loginSuccess,
                                 goBack: goBack)
        return output
    }
}
