//
//  Alarm.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class Alarm: Equatable {
    var fireTimeFromMidnight: NSTimeInterval
    var name: String
    var enabled: Bool
    var uuid: String
    
    
    var fireDate: NSDate? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return nil
        }
        let fireTimeFromThisMOrning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        return fireTimeFromThisMOrning
    }
    
    var fireTimeAsString: String {
      let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        let hours = (fireTimeFromMidnight/60)/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d: %02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d: %02d PM", arguements: [hours, minutes])
        } else {
            return String(format: "%2d: %02d PM", arguments: [hours, minutes])
        }
    }
    
    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool = true, uuid: String = NSUUID().UUIDString){
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        
        
    }
}



func ==(lhs:Alarm, rhs:Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}


