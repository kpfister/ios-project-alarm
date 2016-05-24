//
//  AlarmController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


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