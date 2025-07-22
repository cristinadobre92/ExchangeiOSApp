//
//  MainView.swift
//  ExchangeApp
//
//  Created by Cristina Dobre on 21.07.2025.
//

import SwiftUI

@main
struct MainView: App {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
