//
//  BaseViewController.swift
//  boss
//
//  Created by RyanYuan on 2019/11/21.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit

protocol ViewControllerInitProtocol {
    func initVariables()
    func initSubviews()
    func bindViewModel()
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}
