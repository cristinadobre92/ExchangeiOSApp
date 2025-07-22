//
//  SceneFactory.swift
//  UILibrary
//
//  Created by Cristina Dobre on 22.07.2025.
//

import SwiftUI
import NetworkLibrary

@MainActor
public enum SceneFactory {
    
    static let networkService = NetworkService.shared
    
    public static func makeCurrenciesView() -> some View {
        let viewModel = CurrenciesViewModel(currencyFetching: networkService)
        
        return CurrenciesView(viewModel: viewModel)
    }
    
    public static func makeSettingsView() -> some View {
        let viewModel = SettingsViewModel()
        
        return SettingsView(viewModel: viewModel)
    }
}
