//
//  BaseTableView.swift
//  boss
//
//  Created by RyanYuan on 2019/11/28.
//  Copyright © 2019 RYRxSwift+MVVM. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUp()
    }

    private func setUp() {
        self.separatorColor = R.color.cE4E4E4()!
        self.separatorInset = UIEdgeInsets.zero
        self.rowHeight = 48
        self.estimatedRowHeight = 0
        self.backgroundColor = R.color.cF7F7F7()
        self.estimatedSectionFooterHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.tableFooterView = UIView()
    }
}
