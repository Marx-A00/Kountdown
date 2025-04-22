import SwiftUI

struct SetupView: View {
    @Binding var targetDate: Date
    var onStart: () -> Void
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("KOUNTDOWN")
                .font(.system(size: 28, weight: .light, design: .default))
                .tracking(5)
                .scaleEffect(isAnimating ? 1.02 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
            
            VStack(spacing: 20) {
                Text("SELECT DATE")
                    .font(.caption)
                    .fontWeight(.medium)
                    .tracking(2)
                
                DatePicker(
                    "Target Date & Time",
                    selection: $targetDate,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .accentColor(.black)
            }
            .padding(.vertical, 30)
            
            Button(action: onStart) {
                Text("START")
                    .font(.headline)
                    .fontWeight(.light)
                    .tracking(2)
                    .frame(width: 200, height: 45)
                    .background(Color.black)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    SetupView(
        targetDate: .constant(Date()),
        onStart: {}
    )
}

