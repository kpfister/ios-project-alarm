//
//  AlarmController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit


class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    private let kAlarms = "alarms"
    
    var alarms: [Alarm] = [] // Add an alarms array property with an empty array as a default value
    
    init () {
        loadFromPersistentStorage()
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(newAlarm)
        saveToPersistentStorage()
        return newAlarm
    }
    
    func updateAlarm(alarm: Alarm, firetimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = firetimeFromMidnight // This says that the alarm(s) - fireTimeFromMidnight (the time the user sets) is Set.
        alarm.name = name // This says that the alarm(s) - name is what the user set it as
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        if let indexOfAlarm = alarms.indexOf(alarm) {
            alarms.removeAtIndex(indexOfAlarm)
        }
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        if let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(kAlarms)) as? [Alarm] {
            self.alarms = alarms
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    
    
}


protocol AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm)
    
    func cancelLocalNotification(alarm: Alarm)
    
}


extension AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm){
        let localNotification = UILocalNotification()
        
        localNotification.alertTitle = "New Alert"
        localNotification.alertBody = "Your alarm is ready"
        localNotification.fireDate = alarm.fireDate
        localNotification.category = alarm.uuid
        localNotification.repeatInterval = .Day
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        // Get an array of all the notifications
        guard let scheduledLocalNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        // Do a for in loop for each notification in the array
        for notification in scheduledLocalNotifications {
            // Do an if statement inside of the for in loop to see if the notification.category == alarm.uuid
            if notification.category == alarm.uuid {
                // cancel that notification inside the if
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
        
    }
}