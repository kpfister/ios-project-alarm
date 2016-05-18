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
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.indexOf(alarm) // Looking for the Index, then removing the object at that index.
            else {
                return
        }
        alarms.removeAtIndex(index)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) { // Copied from Master
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    init () {
        loadFromPersistentStorage()
    }
    
//    func mockAlarms() -> [Alarm] {
//        
//        let alarm1 = Alarm(fireTimeFromMidnight: 30421, name:"Wake up", enabled:true)
//        return [alarm1]
//    }
//    
    
    private let kAlarms = "alarms"
    
    func saveToPersistentStorage() {
       NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
       NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(kAlarms))
        guard let alarms =
            NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(kAlarms)) as? [Alarm]
            else {
            return
        }
        self.alarms = alarms
    }
    
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    
    
    
}