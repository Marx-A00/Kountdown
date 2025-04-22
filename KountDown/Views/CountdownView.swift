import SwiftUI

struct CountdownView: View {
    let targetDate: Date
    var onReset: () -> Void
    
    @State private var now: Date = Date()
    @State private var isAnimating = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var timeRemaining: TimeInterval {
        max(targetDate.timeIntervalSince(now), 0)
    }
    
    var isCompleted: Bool {
        timeRemaining == 0
    }
    
    var timeComponents: (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let interval = Int(timeRemaining)
        let days = interval / 86400
        let hours = (interval % 86400) / 3600
        let minutes = (interval % 3600) / 60
        let seconds = interval % 60
        
        return (days, hours, minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 50) {
            Text("COUNTDOWN")
                .font(.system(size: 20, weight: .light, design: .default))
                .tracking(5)
            
            if isCompleted {
                Text("COMPLETED")
                    .font(.system(size: 24, weight: .light, design: .default))
                    .tracking(2)
                    .opacity(isAnimating ? 1.0 : 0.7)
                    .animation(
                        Animation.easeInOut(duration: 1.2)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
            } else {
                HStack(spacing: 20) {
                    MinimalTimeBlock(value: timeComponents.days, unit: "D")
                    Text(":")
                        .font(.system(size: 36, weight: .thin))
                        .offset(y: -8)
                    MinimalTimeBlock(value: timeComponents.hours, unit: "H")
                    Text(":")
                        .font(.system(size: 36, weight: .thin))
                        .offset(y: -8)
                    MinimalTimeBlock(value: timeComponents.minutes, unit: "M")
                    Text(":")
                        .font(.system(size: 36, weight: .thin))
                        .offset(y: -8)
                    MinimalTimeBlock(value: timeComponents.seconds, unit: "S")
                }
            }
            
            Button(action: onReset) {
                Text("RESET")
                    .font(.caption)
                    .fontWeight(.light)
                    .tracking(2)
                    .frame(width: 160, height: 40)
                    .background(Color.black)
                    .foregroundColor(.white)
            }
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onReceive(timer) { input in
            now = input
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct MinimalTimeBlock: View {
    let value: Int
    let unit: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(String(format: "%02d", value))
                .font(.system(size: 36, weight: .light, design: .default))
                .monospacedDigit()
            
            Text(unit)
                .font(.system(size: 12, weight: .light, design: .default))
                .padding(.top, 4)
        }
    }
}

#Preview {
    CountdownView(targetDate: Date().addingTimeInterval(86400),
                  onReset: {})
}

