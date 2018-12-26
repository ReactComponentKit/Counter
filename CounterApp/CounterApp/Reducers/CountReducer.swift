//
//  CountReducer.swift
//  CounterApp
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux
import RxSwift

func countReducer(state: State, action: Action) -> Observable<State> {
    guard var mutableState = state as? CounterState else { return .just(state) }
    
    switch action {
    case let act as IncrementAction:
        mutableState.count += act.payload
    case let act as DecrementAction:
        mutableState.count -= act.payload
    default:
        break
    }
    
    return .just(mutableState)
}
