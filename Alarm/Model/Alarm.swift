//
//  Alarm.swift
//  Alarm
//
//  Created by Deven Day on 9/14/20.
//  Copyright © 2020 Deven Day. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    let name: String
    var enabled: Bool
    var uuid : String
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = UUID().uuidString
    }
    
//    Add a computed property called fireTimeAsString which will return a String representation of the time you want the alarm to fire. This is simply for the UI. *note: Use Apple’s DateFormater class to return a String from your existing fireDate property. *Please Read: https://developer.apple.com/documentation/foundation/dateformatter
    
}// END OF CLASS

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.fireDate == rhs.fireDate
    }
}
