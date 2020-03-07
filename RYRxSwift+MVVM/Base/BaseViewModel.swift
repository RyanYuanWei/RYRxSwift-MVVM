//
//  BaseViewModel.swift
//  boss
//
//  Created by RyanYuan on 2019/12/2.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class BaseViewModel: NSObject {
    
}
