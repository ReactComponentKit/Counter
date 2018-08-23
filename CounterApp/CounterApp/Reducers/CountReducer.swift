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

func countReducer(name: String, state: State?) -> (Action) -> Observable<ReducerResult> {
    return { action in
        guard let prevState = state as? Int else { return Observable.just(ReducerResult(name: name, result: 0)) }
        
        var newState = prevState
        
        switch action {
        case let increment as IncrementAction:
            newState += increment.payload
        case let decrement as DecrementAction:
            newState -= decrement.payload
        default:
            break
        }
        
        return Observable.just(ReducerResult(name: name, result: newState))
        
    }
}
