//
//  KountDownApp.swift
//  KountDown
//
//  Created by Marcos Andrade on 3/31/25.
//

import SwiftUI

@main
struct KountDownApp: App {
    @State private var targetDate: Date = Date()
    @State private var hasStarted = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if hasStarted {
                    CountdownView(
                        targetDate: targetDate,
                        onReset: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                hasStarted = false
                                targetDate = Date()
                            }
                        }
                    )
                    .transition(.opacity)
                } else {
                    SetupView(targetDate: $targetDate) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            hasStarted = true
                        }
                    }
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: hasStarted)
            .preferredColorScheme(.light)
        }
    }
}

