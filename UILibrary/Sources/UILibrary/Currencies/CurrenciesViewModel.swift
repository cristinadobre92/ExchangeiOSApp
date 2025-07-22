import Foundation
import NetworkLibrary

@MainActor
public final class CurrenciesViewModel: ObservableObject {
    @Published var state = CurrenciesViewState()
    
    private let currencyFetching: CurrencyFetching
    
    public init(
        currencyFetching: CurrencyFetching
    ) {
        self.currencyFetching = currencyFetching
    }
}

extension CurrenciesViewModel {
    func fetchData() async {
        do {
            let result = try await currencyFetching.fetchCurrencyData()
            print("CURRENCIES:\n\n\(result)\n")
            
            state.currencies = result
        } catch {
            print("Failed to fetch:", error)
        }
    }
}
