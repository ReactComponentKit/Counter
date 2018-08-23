//
//  CounterViewModel.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import ReactComponentKit
import BKRedux

class CounterViewModel: RootViewModelType {
    override init() {
        super.init()
        store.set(
            state: [
                "count": 0
            ],
            reducers: [
                "count": countReducer
            ])
    }
    
    override func on(newState: [String : State]?) {
        // Send the new state to the sub components
        eventBus.post(event: .on(state: newState))
    }
}
