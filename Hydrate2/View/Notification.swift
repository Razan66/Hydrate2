// NotificationPreferencesView.swift

import SwiftUI

struct NotificationPreferencesView: View {
    @StateObject private var viewModel = NotificationPreferencesViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Notification Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("The start and end hour")
                    .fontWeight(.medium)
                
                Text("Specify the start and end time to receive notifications")
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.503))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Start hour")
                        Spacer()
                        TextField(viewModel.settings.startHour, text: $viewModel.settings.startHour)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $viewModel.settings.startAMPM) {
                            Text("AM").tag(0)
                            Text("PM").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(2)
                    
                    HStack {
                        Text("End hour")
                        Spacer()
                        TextField(viewModel.settings.endHour, text: $viewModel.settings.endHour)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $viewModel.settings.endAMPM) {
                            Text("AM").tag(0)
                            Text("PM").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(2)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Notification interval")
                        .fontWeight(.medium)
                    
                    Text("Specify the interval for notifications")
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.503))
                }
                .padding(.top, 10)
                
                VStack {
                    HStack(spacing: 16) {
                        ForEach(0..<viewModel.minuteIntervals.count) { index in
                            Button(action: {
                                viewModel.selectInterval(minutes: true, index: index)
                            }) {
                                IntervalButtonLabel(value: viewModel.minuteIntervals[index], unit: "Mins", isSelected: viewModel.isSelectedInterval(minutes: true, index: index))
                            }
                        }
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(0..<viewModel.hourIntervals.count) { index in
                            Button(action: {
                                viewModel.selectInterval(minutes: false, index: index)
                            }) {
                                IntervalButtonLabel(value: viewModel.hourIntervals[index], unit: "Hours", isSelected: viewModel.isSelectedInterval(minutes: false, index: index))
                            }
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: IntakeView()) {
                    Text("Start")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .cornerRadius(16)
                }
            }
            .padding()
        }.navigationBarBackButtonHidden(true)
    }
}

// Helper view for interval buttons
struct IntervalButtonLabel: View {
    let value: Int
    let unit: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Text("\(value)")
                .foregroundColor(Color(red: 0.192, green: 0.68, blue: 0.903))
                .font(.system(size: 20))
            Text(unit)
                .foregroundColor(Color.black)
                .font(.system(size: 17))
        }
        .font(.title3)
        .padding()
        .frame(maxWidth: 80, maxHeight: 80)
        .background(isSelected ? Color.blue.opacity(0.2) : Color(UIColor.systemGray6))
        .cornerRadius(16)
        .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 0)
    }
}

struct NotificationPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPreferencesView()
    }
}
