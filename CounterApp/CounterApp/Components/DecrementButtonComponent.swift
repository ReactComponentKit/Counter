//
//  DecrementButtonComponent.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit
import RxSwift
import RxCocoa

class DecrementButtonComponent: UIViewComponent {
    
    private let disposeBag = DisposeBag()
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("-", for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        button.rx.tap.map { DecrementAction(payload: 1) }.bind(onNext: dispatch).disposed(by: disposeBag)
        
        return button
    }()
    
    override func setupView() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
