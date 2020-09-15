//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Deven Day on 9/14/20.
//  Copyright © 2020 Deven Day. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmEnableDisableButton: UIButton!
    
    var alarm: Alarm?
    
    var alarmIsON: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsON.toggle()
        alarmEnableDisableButton.setTitle(alarmIsON ? "On" : "Off" , for: .normal)
        alarmEnableDisableButton.backgroundColor = alarmIsON ? .green : .red
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alarmTitleTextField.text else {return}
        let fireDate = datePicker.date
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, name: name, fireDate: fireDate, enabled: alarmIsON)
        } else {
            AlarmController.sharedInstance.addAlarm(fireDate: fireDate, name: name, enabled: alarmIsON)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if let alarm = alarm {
            datePicker.date = alarm.fireDate
            alarmTitleTextField.text = alarm.name
            alarmIsON = alarm.enabled
        }
        alarmEnableDisableButton.setTitle(alarmIsON ? "On" : "Off" , for: .normal)
        alarmEnableDisableButton.backgroundColor = alarmIsON ? .green : .red
       
    }
}
