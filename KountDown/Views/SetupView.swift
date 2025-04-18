import SwiftUI

struct SetupView: View {
    @Binding var targetDate: Date
    var onStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your countdown target")
                .font(.title)

            DatePicker(
                "Target Date & Time",
                selection: $targetDate,
                in: Date()...,
                displayedComponents: [.date, .hourAndMinute]
            )
            .scaleEffect(1.5)
            .labelsHidden()
            .frame(maxWidth: .infinity)
            .padding(.vertical)

            Button(action: onStart) {
                Text("Start Kount Down")
                    .font(.headline)
                    .padding()
            }
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    SetupView(
        targetDate: .constant(Date()),
        onStart: {}
    )
}

