//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Karl Pfister on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()
        
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        cell.updateWithAlarm(alarm)
        cell.delegate = self
        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
       
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailViewController = segue.destinationViewController as? AlarmDetailTableViewController
        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow
                else {
                    return
                }
                let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
                detailViewController?.alarm = alarm
            }
            
         
        
    }
    
    
}

// MARK: - SwitchTableViewCell delegate methods
extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
    }
}
