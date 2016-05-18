//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm?
    
    
    //MARK: - Outlets and Properties
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var alarmText: UITextField!
    
    @IBOutlet weak var enableAlarmButton: UIButton!
    
    //MARK: - Life Cyle
    
    
    override func viewDidLoad() { // Copied from master. I was unsure how to unwrap the alarm...
        super.viewDidLoad()
        if let alarm = alarm { // This unwraps alarm
            updateWithAlarm(alarm)
        }
        AlarmController.sharedInstance.loadFromPersistentStorage()
        setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    func setupView() {
        
        if alarm == nil { // if alarm is equal to nil ( not on? )
            enableAlarmButton.hidden = true // hide the enable button
        } else {
            enableAlarmButton.hidden = false // if the alarm is off, show the enable button
            if alarm?.enabled == true {
                enableAlarmButton.setTitle("Disable", forState: .Normal)
                enableAlarmButton.setTitleColor(.blackColor(), forState: .Normal)
                enableAlarmButton.backgroundColor = .redColor()
            } else {
                enableAlarmButton.setTitle("Enable", forState: .Normal)
                enableAlarmButton.setTitleColor(.blackColor(), forState: .Normal)
                enableAlarmButton.backgroundColor = .greenColor()
            }
        }
        
        
    }
    
    
    func updateWithAlarm(alarm: Alarm) {
        
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false) // ^ and below copied from master.
        alarmText.text = alarm.name
        self.title = alarm.name
        
    }
    
    
    //MARK: - Actions
    
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return
        }
        AlarmController.sharedInstance.toggleEnabled(alarm)
        setupView()
    }
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = alarmText.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
                return
        }
        let timeIntervalFromMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalFromMidnight, name: title) }
        else {
            AlarmController.sharedInstance.addAlarm(timeIntervalFromMidnight, name: title)
        }
        navigationController?.popViewControllerAnimated(true)
    }
}



