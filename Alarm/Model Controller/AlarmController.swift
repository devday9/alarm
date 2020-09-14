//
//  AlarmController.swift
//  Alarm
//
//  Created by Deven Day on 9/14/20.
//  Copyright © 2020 Deven Day. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: true, uuid: "")
        alarms.append(newAlarm)
    }
     
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
    }
}
