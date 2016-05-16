//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    
    
    //MARK: - Actions
    
    
    @IBAction func switchValueChanged(sender: AnyObject) {
    }
    
    
    
    
    
}
