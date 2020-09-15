//
//  Alarm.swift
//  Alarm
//
//  Created by Deven Day on 9/14/20.
//  Copyright © 2020 Deven Day. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var name: String
    var fireDate: Date
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
    
    init(name: String, fireDate: Date, enabled: Bool, uuid: String = UUID().uuidString) {
        self.name = name
        self.fireDate = fireDate
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
