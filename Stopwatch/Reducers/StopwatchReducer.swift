//
//  StopwatchReducer.swift
//  Stopwatch
//
//  Created by jeonhyeong cho on 2019/11/06.
//  Copyright © 2019 jeonhyeong cho. All rights reserved.
//

import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives

func stopwatchReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()
    
    switch action {
    case _ as StopwatchAddAction:
        state.count += 1
    case _ as StopwatchResetAction:
        state.count = 0
    case _ as ResetButtonEnableAction:
        state.resetButtonEnableState = true
    case _ as ResetButtonDisableAction:
        state.resetButtonEnableState = false
    default:
        break
    }
    
    return state
}


