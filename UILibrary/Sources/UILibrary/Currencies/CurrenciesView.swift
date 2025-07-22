import Foundation
import SwiftUI

// MARK: - Exchange Rate View
public struct CurrenciesView: View {
    @ObservedObject private var viewModel: CurrenciesViewModel
    
    public init(viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
    }
        
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    public var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Form {
                    Section(header: Text("Amount in CZK")) {
                        TextField("Enter amount", text: $viewModel.state.amountCZK)
                            .keyboardType(.decimalPad)
                    }
                    
                    Picker(
                        "Currency",
                        selection: $viewModel.state.selectedCurrencyIndex
                    ) {
                        ForEach(0..<viewModel.state.currencies.count, id: \.self) { index in
                            Text(viewModel.state.currencies[index].code)
                        }
                    }
                    
                    Section(header: Text("Converted Amount")) {
                        Text(String(format: "%.2f", viewModel.state.convertedAmount))
                            .font(.title)
                            .bold()
                    }
                }
                
                Spacer()
                
                ZStack {
                    if viewModel.state.showDate {
                        Text(DateFormatters.dayMonthYear.string(from: Date()))
                            .font(.footnote)
                            .transition(.opacity)
                    } else {
                        Text("Today is...")
                            .font(.footnote)
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.8), value: viewModel.state.showDate)
                .onReceive(timer) { _ in
                    withAnimation {
                        viewModel.state.showDate.toggle()
                    }
                }
            }
            .navigationTitle("CZK Converter")
            .task {
                await viewModel.fetchData()
            }
        }
    }
}
