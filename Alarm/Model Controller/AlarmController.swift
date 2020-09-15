//
//  AlarmController.swift
//  Alarm
//
//  Created by Deven Day on 9/14/20.
//  Copyright © 2020 Deven Day. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func cancelUserNotifications(for alarm: Alarm)
    func sheduleUserNotifications(for alarm: Alarm)
}

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
//    var mockAlarms: [Alarm] {
//        return [
//            Alarm(name: "WAKE UP!!!!!!", fireDate: Date(), enabled: true),
//            Alarm(name: "Buy Groceries!", fireDate: Date(), enabled: true)
//        ]
//    }
    
    init() {
        loadFromPersistentStore()
    }
    
    private static var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "Alarm.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
   func addAlarm(fireDate: Date, name: String, enabled: Bool) -> Alarm {
       let newAlarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
       alarms.append(newAlarm)
       if newAlarm.enabled {
           scheduleUserNotifications(for: newAlarm)
       } else {
           cancelUserNotifications(for: newAlarm)
       }
       saveToPersistentStore()
       return newAlarm
   }
    
    func updateAlarm(alarm: Alarm, name: String, fireDate: Date, enabled: Bool) {
        alarm.name = name
        alarm.fireDate = fireDate
        alarm.enabled = enabled
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(AlarmController.sharedInstance.alarms)
            try data.write(to: AlarmController.fileURL)
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: AlarmController.fileURL)
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: data)
            self.alarms = decodedAlarms
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
}//END OF CLASS

//MARK: - Extensions
extension AlarmController: AlarmScheduler {
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Alarm"
        notificationContent.body = "Your alarm is ringing"
        
        let date = alarm.fireDate
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}

