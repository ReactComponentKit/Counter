//
//  CounterViewModel.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import ReactComponentKit

struct CounterState: State, CountLabelComponentState {
    var count: Int = 0
    var error: RCKError? = nil
}

class CounterViewModel: RCKViewModel<CounterState> {
    
    override func setupStore() {
        initStore { store in
            store.initial(state: CounterState())
        }
    }
    
    func increase(count: Int) {
         setState {
            $0.copy { $0.count += count }
        }
    }
    
    func decrease(count: Int) {
        setState {
            $0.copy { $0.count -= count }
        }
    }
}

