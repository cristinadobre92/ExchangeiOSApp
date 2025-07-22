import Foundation
import NetworkLibrary

struct CurrenciesViewState {
    var currencies: [CurrencyEntry] = []
    var amountCZK: String = "1"
    var selectedCurrencyIndex: Int = 0
    var showDate = false
    var convertedAmount: Double {
        guard let czk = Double(amountCZK),
              currencies.indices.contains(selectedCurrencyIndex) else {
            return 0.0
        }
        let currency = currencies[selectedCurrencyIndex]
        return czk * currency.rate
    }
}
