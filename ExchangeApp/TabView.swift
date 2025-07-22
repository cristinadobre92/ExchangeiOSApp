//
//  ContentView.swift
//  ExchangeApp
//
//  Created by Cristina Dobre on 21.07.2025.
//

import SwiftUI
import UILibrary

struct ContentView: View {
    var body: some View {
        TabView {
            SceneFactory.makeCurrenciesView()
                .tabItem {
                    Image("currency")
                        .renderingMode(.template)
                }

            SceneFactory.makeSettingsView()
                .tabItem {
                        Image("home")
                        .renderingMode(.template)
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    ContentView()
}
