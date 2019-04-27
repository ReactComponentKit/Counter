//
//  CountLabelComponent.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux
import ReactComponentKit
import SnapKit

protocol CountLabelComponentState {
    var count: Int { get }
}

class CountLabelComponent: UIViewComponent {
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.black
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    override var contentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    override func setupView() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func on(state: State) {
        guard let countState = state as? CountLabelComponentState else { return }
        label.text = String(countState.count)
    }
}
