import SwiftUI

struct CountdownView: View {
    let targetDate: Date
    var onReset: () -> Void
    
    @State private var now: Date = Date()
    @State private var isAnimating = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Define colors using RGB directly
    let creamColor = Color(red: 248/255, green: 237/255, blue: 217/255)
    let darkColor = Color(red: 11/255, green: 18/255, blue: 21/255)

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
        VStack {
            Spacer()
            
            Text("COUNTDOWN")
                .font(.system(size: 30, weight: .light, design: .default))
                .foregroundColor(darkColor)
                .tracking(8)
                .padding(.bottom, 60)
            
            if isCompleted {
                Text("COMPLETED")
                    .font(.system(size: 42, weight: .light, design: .default))
                    .foregroundColor(darkColor)
                    .tracking(4)
                    .opacity(isAnimating ? 1.0 : 0.7)
                    .animation(
                        Animation.easeInOut(duration: 1.2)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                    .padding(.bottom, 60)
            } else {
                HStack(spacing: 16) {
                    TimeColumn(value: timeComponents.days, unit: "DAYS", textColor: darkColor)
                    
                    Text(":")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundColor(darkColor)
                        .offset(y: -10)
                        
                    TimeColumn(value: timeComponents.hours, unit: "HOURS", textColor: darkColor)
                    
                    Text(":")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundColor(darkColor)
                        .offset(y: -10)
                        
                    TimeColumn(value: timeComponents.minutes, unit: "MINS", textColor: darkColor)
                    
                    Text(":")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundColor(darkColor)
                        .offset(y: -10)
                        
                    TimeColumn(value: timeComponents.seconds, unit: "SECS", textColor: darkColor)
                }
                .padding(.horizontal)
                .padding(.bottom, 60)
            }
            
            Spacer()
            
            Button(action: onReset) {
                Text("RESET")
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
        .onReceive(timer) { input in
            now = input
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct TimeColumn: View {
    let value: Int
    let unit: String
    let textColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(String(format: "%02d", value))
                .font(.system(size: 56, weight: .light))
                .foregroundColor(textColor)
                .monospacedDigit()
            
            Text(unit)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(textColor)
                .tracking(1)
        }
        .frame(width: 80)
    }
}

#Preview {
    CountdownView(targetDate: Date().addingTimeInterval(86400),
                  onReset: {})
}

