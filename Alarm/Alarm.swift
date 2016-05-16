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
    
    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool, uuid: String){
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = true
        self.uuid = NSUUID().UUIDString
        
//        var fireDate: NSDate?
//        
//        get {
//            return
//        }
    }
}

func ==(lhs:Alarm, rhs:Alarm) -> Bool {
    return lhs.fireTimeFromMidnight == rhs.fireTimeFromMidnight && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid
}


