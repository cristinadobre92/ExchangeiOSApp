import SwiftUI

public struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    public init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Text("Current user: \(viewModel.username.isEmpty ? "Guest" : viewModel.username)!")
                    .font(.title)
                    .padding()
                
                Button("Clear user defaults for next session") {
                    viewModel.deleteUserDefaults()
                }
            }
        }
        .navigationTitle("User details")
        .onAppear {
            if viewModel.username.isEmpty {
                viewModel.showingPopup = true
            }
        }
        .sheet(isPresented: $viewModel.showingPopup) {
            VStack(spacing: 20) {
                Text("Enter your name")
                    .font(.headline)
                
                TextField("Your name", text: $viewModel.tempName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    if !viewModel.tempName.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.username = viewModel.tempName.trimmingCharacters(in: .whitespaces)
                        viewModel.showingPopup = false
                    }
                }
                .disabled(viewModel.tempName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }  
    }
}
