//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell{
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    
    
    //MARK: - Actions
    
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        
        delegate?.switchCellSwitchValueChanged(self)
    }
    
    
    
    //MARK: - functions of Cell
    
    func updateWithAlarm(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString // Our timeLabel will be filled with text - and its coming from alarm.fireTimeString
        nameLabel.text = alarm.name // our nameLabel will be
        alarmSwitch.on = alarm.enabled
        
    }
    
    
} // End of Class

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}











