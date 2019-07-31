//
//  SecondViewController.swift
//  DualViewCountdownTimer
//
//  Created by Cheyenne Vlymen-Williams on 7/29/19.
//  Copyright © 2019 Cheyenne Vlymen-Williams. All rights reserved.
//

import UIKit

let date = Date()
let calendar = Calendar.current
let components = calendar.dateComponents([.month, .year, .day, .hour, .minute, .second], from: date as Date)
let currentDate = calendar.date(from: components)
let userCalendar = Calendar.current
let weddingDate = DateComponents(year: 2020, month: 6, day: 20, hour: 11, minute: 0, second: 0)
let weddingDay = userCalendar.date(from: weddingDate as DateComponents)!
let weddingDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: weddingDay)
var countdownTimer: Timer!
var totalTime = weddingDayDifference

var running = false

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var rings: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
            startTimer()
    
    }
    
    func startTimer() {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted())"
        
        if totalTime.day == 0 && totalTime.hour == 0 && totalTime.minute == 0 && totalTime.second == 0 {
            endTimer()
        }
            
        else if totalTime.hour == 0 && totalTime.minute == 0 && totalTime.second == 0{
            totalTime.day! -= 1
            totalTime.hour = 23
            totalTime.minute = 59
            totalTime.second = 59
        }
            
        else if totalTime.minute == 0 && totalTime.second == 0{
            totalTime.hour! -= 1
            totalTime.minute! -= 59
            totalTime.second! = 59
        }
            
        else if totalTime.second == 0{
            totalTime.minute! -= 1
            totalTime.second = 59
        }
            
        else {
            totalTime.second! -= 1
        }
    }
    
    func endTimer() {
        timerLabel.text = "You're offically a Mrs!"
        countdownTimer.invalidate()
    }
    
    func timeFormatted() -> String {
        let days:Int = totalTime.day!
        let hours: Int = totalTime.hour!
        let seconds: Int = totalTime.second!
        let minutes: Int = totalTime.minute!
        //     let hours: Int = totalSeconds / 3600
        
        rings.image = UIImage.init(named: "wedding-ring")
        
        return String("\(days) days \n \(hours) hours \n \(minutes) minutes \n \(seconds) seconds \n until you say I DO!!")
    }

}
