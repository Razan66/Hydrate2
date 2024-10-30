//
//  ContentViewModel.swift
//  Hydrate
//
//  Created by Razan on 26/04/1446 AH.
//

// UserDataModel.swift

import Foundation

struct UserDataModel {
    static let defaults = UserDefaults.standard
    
    static func saveBodyWeight(_ bodyWeight: Double) {
        let targetHydration = bodyWeight * 0.03
        defaults.set(targetHydration, forKey: "bodyWeight")
    }
}
