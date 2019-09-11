//
//  CounterAppTests.swift
//  CounterAppTests
//
//  Created by burt on 2018. 8. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import XCTest
@testable import CounterApp

class CounterViewModelTests: XCTestCase {
    
    private let viewModel = CounterViewModel()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel.setState {
            var mutableState = $0
            mutableState.count = 0
            return mutableState
        }
    }
    
    func testIncrease() {
        viewModel.increase(count: 1)
        viewModel.withState { (state) in
            XCTAssertEqual(state.count, 1)
        }
    }
    
    func testDecrease() {
        viewModel.decrease(count: 1)
        viewModel.withState { (state) in
            XCTAssertEqual(state.count, -1)
        }
    }
        
}
