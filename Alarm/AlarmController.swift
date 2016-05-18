//
//  AlarmController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//


import UIKit // I dont need Foundation becauce UIkit comes with it.


class AlarmController {
    
    static let sharedInstance = AlarmController() // This allows us to use this instance as a shared instance
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.indexOf(alarm) // Looking for the Index, then removing the object at that index.
            else {
                return
        }
        alarms.removeAtIndex(index)
    }
    
    func toggleEnabled(alarm: Alarm) { // Copied from Master
        alarm.enabled = !alarm.enabled
    }
    
    func mockAlarms() -> [Alarm] {
        
        let alarm1 = Alarm(fireTimeFromMidnight: 30421, name:"Wake up", enabled:true)
        return [alarm1]
    }
    
    init() {
        self.alarms = mockAlarms()
    }
    
    
    
    
    
}