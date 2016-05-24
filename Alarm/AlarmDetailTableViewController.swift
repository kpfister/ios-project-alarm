//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    var alarm: Alarm?
    
    
    // MARK: Outlets -
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var alarmTextName: UITextField!
    
    @IBOutlet weak var enableButton: UIButton!
    
    
    
    // MARK: Actions -
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return
        }
        AlarmController.sharedInstance.toggleEnabled(alarm)
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        setUpView()
        
    }
    
    
    
    @IBAction func savebuttonTapped(sender: AnyObject) {
        guard let title = alarmTextName.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm, firetimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelLocalNotification(alarm)
            scheduleLocalNotification(alarm)
        } else {
            let alarm = AlarmController.sharedInstance.addAlarm(timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleLocalNotification(alarm)
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    func updateWithAlarm(alarm: Alarm) {
        guard let unwrappedFireDate = alarm.fireDate else {
            return
        }
        
        datePicker.date = unwrappedFireDate
        alarmTextName.text = alarm.name
        
    }
    
    func setUpView() {
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", forState: .Normal)
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
                enableButton.backgroundColor = .redColor()
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.setTitleColor(.blackColor(), forState: .Normal)
                enableButton.backgroundColor = .greenColor()
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = self.alarm { // This is unwrapped
            updateWithAlarm(alarm)
        }
        setUpView()
    }
    
}
