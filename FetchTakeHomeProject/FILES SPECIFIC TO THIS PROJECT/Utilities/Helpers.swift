//
//  CircadianInterval.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/25/24.
//

import Foundation
import SwiftUI

public enum CircadianInterval: String, Equatable, CaseIterable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
    case day = "Day"
}

public extension Date {
    /// The day's current circadian interval. (i.e. morning, afternoon, evening, night.)
    ///
    /// The intervals are based on the following timeframes:\
    /// Morning: 3AM – 12PM\
    /// Afternoon: 12PM – 5PM\
    /// Evening: 5PM – 11PM\
    /// Night: 11PM – 3AM\
    /// Day: default\
    func getCircadianInterval() -> CircadianInterval {
        print("\(type(of: self)).\(#function)")
        let calendar = Calendar.current
        guard
            let morningMin = calendar.date(bySettingHour: 3, minute: 0, second: 1, of: self),
            let morningMax = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self),
            
                let afternoonMin = calendar.date(bySettingHour: 12, minute: 0, second: 1, of: self),
            let afternoonMax = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: self),
            
                let eveningMin = calendar.date(bySettingHour: 17, minute: 0, second: 1, of: self),
            let eveningMax = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: self),
            
                let night1Min = calendar.date(bySettingHour: 23, minute: 0, second: 1, of: self),
            let night1Max = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self),
            
                let night2Min = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self),
            let night2Max = calendar.date(bySettingHour: 3, minute: 0, second: 0, of: self)
        else { return .day }
        
        let morning = morningMin...morningMax
        let afternoon = afternoonMin...afternoonMax
        let evening = eveningMin...eveningMax
        let night1 = night1Min...night1Max
        let night2 = night2Min...night2Max
        
        if morning.contains(self) {
            return .morning
        } else if afternoon.contains(self) {
            return .afternoon
        } else if evening.contains(self) {
            return .evening
        } else if night1.contains(self) || night2.contains(self) {
            return .night
        }
        return .day
    }
}

