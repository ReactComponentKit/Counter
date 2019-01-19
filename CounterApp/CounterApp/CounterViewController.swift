//
//  ViewController.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import ReactComponentKit

class CounterViewController: UIViewController {
    
    private lazy var viewModel: CounterViewModel = {
        return CounterViewModel()
    }()
    
    private lazy var countLabel: CountLabelComponent = {
        return CountLabelComponent(token: viewModel.token)
    }()
    
    private lazy var incrementButton: IncrementButtonComponent = {
        return IncrementButtonComponent(token: viewModel.token, receiveState: false)
    }()
    
    private lazy var decrementButton: DecrementButtonComponent = {
        return DecrementButtonComponent(token: viewModel.token, receiveState: false)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countLabel)
        view.addSubview(incrementButton)
        view.addSubview(decrementButton)
        
        countLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        decrementButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(48)
        }
        
        incrementButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(48)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}

