import SwiftUI

struct CountdownView: View {
    let targetDate: Date
    var onReset: () -> Void
    
    
    @State private var now: Date = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var timeRemaining: TimeInterval {
        max(targetDate.timeIntervalSince(now), 0)
    }

    var formattedTime: String {
        let interval = Int(timeRemaining)
        let days = interval / 86400
        let hours = (interval % 86400) / 3600
        let minutes = (interval % 3600) / 60
        let seconds = interval % 60

        return String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(formattedTime)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()
                .onReceive(timer) { input in
                    now = input
                }

            Button(action: onReset) {
                Text("Reset")
                    .font(.caption)
                    .padding()
                // Optional reset logic later
            }
            .foregroundColor(.gray)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    CountdownView(targetDate: Date().addingTimeInterval(86400),
                  onReset: {})
}

