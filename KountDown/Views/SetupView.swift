import SwiftUI

struct SetupView: View {
    @Binding var targetDate: Date
    var onStart: () -> Void
    @State private var isAnimating = false
    
    // Define colors using RGB directly
    let creamColor = Color(red: 248/255, green: 237/255, blue: 217/255)
    let darkColor = Color(red: 11/255, green: 18/255, blue: 21/255)
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("KOUNTDOWN")
                .font(.system(size: 42, weight: .light, design: .default))
                .tracking(8)
                .foregroundColor(darkColor)
                .scaleEffect(isAnimating ? 1.02 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .padding(.bottom, 80)
            
            VStack(spacing: 25) {
                Text("SELECT DATE")
                    .font(.system(size: 18, weight: .medium))
                    .tracking(4)
                    .foregroundColor(darkColor)
                    .padding(.bottom, 10)
                
                DatePicker(
                    "Target Date & Time",
                    selection: $targetDate,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .labelsHidden()
                .accentColor(darkColor)
                .scaleEffect(1.2)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            }
            .padding(.horizontal)
            .padding(.vertical, 40)
            
            Spacer()
            
            Button(action: onStart) {
                Text("START")
                    .font(.system(size: 22, weight: .light))
                    .tracking(4)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(darkColor)
                    .foregroundColor(creamColor)
            }
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(creamColor)
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

