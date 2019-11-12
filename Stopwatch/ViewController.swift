//
//  ViewController.swift
//  Stopwatch
//
//  Created by jeonhyeong cho on 2019/10/17.
//  Copyright © 2019 jeonhyeong cho. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    func newState(state: AppState) {
        updateTime(state.count)
        updateEnableStateForResetButton(state.resetButtonEnableState)
    }
    
    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet weak var textFieldMinute: UITextField!
    @IBOutlet weak var textFieldSecond: UITextField!
    @IBOutlet weak var buttonReset: UIButton!
    
    var count = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscribe to state changes
        mainStore.subscribe(self)
    }
    
    @objc func add() {
        mainStore.dispatch(StopwatchAddAction())
    }
    
    func updateTime(_ count: Int) {
        var minute = String(count/60)
        var second = String(count - 60*Int(minute)!)
        
        if minute.count < 2 {
            minute = "0" + minute
        }
        if second.count < 2 {
            second = "0" + second
        }
        
        textFieldMinute.text = minute
        textFieldSecond.text = second
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        if timer.isValid {
            return
        }
        if buttonReset.isEnabled {
            mainStore.dispatch(ResetButtonDisableAction())
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(add), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        if !timer.isValid {
            return
        }
        timer.invalidate()
        mainStore.dispatch(ResetButtonEnableAction())
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        mainStore.dispatch(StopwatchResetAction())
        mainStore.dispatch(ResetButtonDisableAction())
    }
    
    func updateEnableStateForResetButton(_ state: Bool) {
        if state == buttonReset.isEnabled {
            return
        }
        
        buttonReset.isEnabled = state
        state ? buttonReset.setTitleColor(.white, for: .normal) : buttonReset.setTitleColor(.lightGray, for: .normal)
    }
}

