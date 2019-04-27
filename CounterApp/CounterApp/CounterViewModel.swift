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

struct CounterState: State, CountLabelComponentState {
    var count: Int = 0
    var error: (Error, Action)? = nil
}

class CounterViewModel: RootViewModelType<CounterState> {
    override init() {
        super.init()
        store.set(
            initialState: CounterState(),
            reducers: [
                countReducer
            ])
    }
    
    override func on(newState: CounterState) {
        // Send the new state to the sub components
        propagate(state: newState)
    }
}
