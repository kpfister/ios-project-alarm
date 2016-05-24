//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: SwitchTableViewCellDelegate?

    
       // MARK: Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    // MARK: Actions

    @IBAction func switchValueChanged(sender: AnyObject) {
        // This is where the Protocol will go.
        delegate?.switchCellSwitchValueChanged(self) //Update the switchValueChanged IBAction to check if a delegate is assigned, and if so, call the delegate protocol function  
    }
    
    
    
    func updateWithAlarm(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
    
}

protocol SwitchTableViewCellDelegate: class { // Protocol goes outside of the class
    func switchCellSwitchValueChanged(Cell: SwitchTableViewCell)
    
}

