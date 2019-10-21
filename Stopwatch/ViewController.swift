//
//  ViewController.swift
//  Stopwatch
//
//  Created by jeonhyeong cho on 2019/10/17.
//  Copyright © 2019 jeonhyeong cho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldMinute: UITextField!
    @IBOutlet weak var textFieldSecond: UITextField!
    @IBOutlet weak var buttonReset: UIButton!
    
    var count = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func add() {
        count+=1
        updateTime()
    }
    
    func updateTime() {
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
            updateEnableStateForResetButton(false)
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(add), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        if !timer.isValid {
            return
        }
        timer.invalidate()
        updateEnableStateForResetButton(true)
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        count = 0
        updateTime()
        updateEnableStateForResetButton(false)
    }
    
    func updateEnableStateForResetButton(_ state: Bool) {
        if state {
            buttonReset.isEnabled = true
            buttonReset.setTitleColor(.white, for: .normal)
            return
        }
        buttonReset.isEnabled = false
        buttonReset.setTitleColor(.lightGray, for: .normal)
    }
}

