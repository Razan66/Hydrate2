//
//  NotificationViewModel.swift
//  Hydrate
//
//  Created by Razan on 26/04/1446 AH.
//

// NotificationPreferencesViewModel.swift

import SwiftUI

class NotificationPreferencesViewModel: ObservableObject {
    @Published var settings = NotificationSettingsModel(startHour: "3:00", startAMPM: 0, endHour: "3:00", endAMPM: 0, notificationInterval: 0)

    let minuteIntervals = [15, 30, 60, 90]
    let hourIntervals = [2, 3, 4, 5]
    
    func selectInterval(minutes: Bool, index: Int) {
        settings.notificationInterval = minutes ? index : index + minuteIntervals.count
    }
    
    func isSelectedInterval(minutes: Bool, index: Int) -> Bool {
        return settings.notificationInterval == (minutes ? index : index + minuteIntervals.count)
    }
}
