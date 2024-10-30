//
//  IntakeViewModel.swift
//  Hydrate
//
//  Created by Razan on 26/04/1446 AH.
//

import SwiftUI

class IntakeViewModel: ObservableObject {
    @Published var intakeData = IntakeModel()
    let defaults = UserDefaults.standard

    let systemIcons = ["zzz", "tortoise.fill", "hare.fill", "hands.clap.fill"]

    init() {
        loadIntakeGoal()
    }

    func loadIntakeGoal() {
        intakeData.goalIntake = defaults.double(forKey: "bodyWeight")
        if intakeData.goalIntake == 0 {
            intakeData.goalIntake = intakeData.defaultIntake
        }
    }

    func increaseIntake(by amount: Double) {
        intakeData.currentIntake = min(intakeData.currentIntake + amount, intakeData.goalIntake)
    }

    func getIconForCurrentIntake() -> String {
        let progress = intakeData.goalIntake > 0 ? intakeData.currentIntake / intakeData.goalIntake : 0
        let index = min(Int(progress * Double(systemIcons.count)), systemIcons.count - 1)
        return systemIcons[index]
    }
}
