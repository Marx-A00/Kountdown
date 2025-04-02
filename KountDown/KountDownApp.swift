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
            if hasStarted {
                CountdownView(
                    targetDate: targetDate,
                    onReset: {
                        hasStarted = false
                        targetDate = Date()
                    }
                )
    
            } else {
                SetupView(targetDate: $targetDate) {
                    hasStarted = true
                }
            }
        }
    }
}

