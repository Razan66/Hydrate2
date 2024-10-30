//
//  ContentViewModelView.swift
//  Hydrate
//
//  Created by Razan on 26/04/1446 AH.
//

// ContentViewModel.swift

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var bodyWeight: String = ""
    @Published var showError: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    // Function to handle validation and save
    func saveBodyWeight() {
        if bodyWeight.isEmpty || Double(bodyWeight) == nil {
            showError = true
        } else {
            showError = false
            if let weight = Double(bodyWeight) {
                UserDataModel.saveBodyWeight(weight)
            }
        }
    }
}
