//
//  AppState.swift
//  Stopwatch
//
//  Created by jeonhyeong cho on 2019/11/06.
//  Copyright © 2019 jeonhyeong cho. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var count = 0
    var resetButtonEnableState = false
}
