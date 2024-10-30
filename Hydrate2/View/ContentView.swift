// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @FocusState private var isBodyWeightFocused: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Image("Drop")
                    .resizable()
                    .frame(width: 60, height: 120)
                    .padding(.top, 10)

                Text("Hydrate")
                    .font(.title)
                    .fontWeight(.medium)

                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.503))
                    .multilineTextAlignment(.leading)

                HStack(alignment: .center, spacing: 3.0) {
                    Text("Body weight").padding()
                    TextField("Value", text: $viewModel.bodyWeight)
                        .keyboardType(.decimalPad)
                        .focused($isBodyWeightFocused)

                    if !viewModel.bodyWeight.isEmpty {
                        Button(action: {
                            viewModel.bodyWeight = "" // Clear the text field
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                }
                .background(Color(.systemGray6))
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .padding(.top, 10)

                Spacer()

                NavigationLink(destination: NotificationPreferencesView()) {
                    Text("Next")
                        .font(.title3)
                        .frame(maxWidth: 340)
                        .padding()
                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .foregroundColor(Color.white)
                        .cornerRadius(16)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.saveBodyWeight()
                    if viewModel.showError {
                        isBodyWeightFocused = true
                    }
                })
                .disabled(viewModel.bodyWeight.isEmpty || Double(viewModel.bodyWeight) == nil)
            }
            .padding(20)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                isBodyWeightFocused = true
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("Please enter a valid body weight."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
