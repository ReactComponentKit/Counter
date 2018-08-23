//
//  IncrementAction.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux

struct IncrementAction: Action {
    let payload: Int
    
    init(payload: Int = 1) {
        self.payload = payload
    }
}
