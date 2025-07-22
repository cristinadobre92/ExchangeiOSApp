import SwiftUI

public final class SettingsViewModel: ObservableObject {
    @Published var showingPopup = false
    @Published var tempName = ""
    @Published var username: String {
            didSet {
                UserDefaults.standard.set(username, forKey: "username")
            }
        }
        
        init() {
            self.username = UserDefaults.standard.string(forKey: "username") ?? ""
        }
    
    func deleteUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
