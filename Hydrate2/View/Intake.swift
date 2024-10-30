import SwiftUI

struct IntakeView: View {
    @StateObject private var viewModel = IntakeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Today's Water Intake")
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.503))

                    HStack {
                        Text(String(format: "%.1f", viewModel.intakeData.currentIntake) + " liter")
                            .fontWeight(.bold)
                            .font(.system(size: 19))
                            .foregroundColor(viewModel.intakeData.currentIntake == viewModel.intakeData.goalIntake ? .green : .black)

                        Text(" / \(String(format: "%.1f", viewModel.intakeData.goalIntake)) liter")
                            .fontWeight(.bold)
                            .font(.system(size: 19))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    viewModel.loadIntakeGoal()
                }

                Spacer()

                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 28, lineCap: .round))
                        .fill(Color(red: 0.933, green: 0.933, blue: 0.942))
                        .frame(width: 313, height: 313)

                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.intakeData.currentIntake / max(viewModel.intakeData.goalIntake, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 28, lineCap: .round))
                        .fill(Color.cyan)
                        .frame(width: 313, height: 313)
                        .rotationEffect(.degrees(-90))

                    Image(systemName: viewModel.getIconForCurrentIntake())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90)
                        .foregroundColor(.yellow)
                }

                Spacer()

                HStack {
                    Text(String(format: "%.1f", viewModel.intakeData.currentIntake))
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    Text("L")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                }
                .padding()

                Stepper("", value: $viewModel.intakeData.currentIntake, in: 0...viewModel.intakeData.goalIntake, step: 0.1)
                    .labelsHidden()
                    .onChange(of: viewModel.intakeData.currentIntake) { _ in
                        viewModel.increaseIntake(by: 0.1)
                    }
            }
            .padding()
            .navigationTitle("Water Intake")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    IntakeView()
}
