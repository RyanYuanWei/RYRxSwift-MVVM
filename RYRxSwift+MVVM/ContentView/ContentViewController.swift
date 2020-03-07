//
//  ContentViewController.swift
//  RYRxSwift+MVVM
//
//  Created by RyanYuan on 2020/3/6.
//  Copyright © 2020 RyanYuan. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
        let navigator = DefaultLoginWithPhoneNavigator.init(viewController: self)
        navigator.toLoginWithPhone()
    }
}
