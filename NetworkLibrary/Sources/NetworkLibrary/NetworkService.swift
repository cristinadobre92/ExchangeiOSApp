import Foundation

public final class NetworkService {
    
    public static let shared = NetworkService()
}

public protocol CurrencyFetching: Sendable {
    func fetchCurrencyData() async throws -> [CurrencyEntry]
}

extension NetworkService: CurrencyFetching {
    public func fetchCurrencyData() async throws -> [CurrencyEntry] {
        guard let url = URL(string: "https://www.cnb.cz/en/financial-markets/foreign-exchange-market/central-bank-exchange-rate-fixing/central-bank-exchange-rate-fixing/daily.txt") else {
            print("Invalid URL error")
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let text = String(data: data, encoding: .utf8) else {
                print("Invalid Data error")
                throw NetworkError.invalidData
            }
            
            var results: [CurrencyEntry] = []

            let lines = text.components(separatedBy: .newlines)
            for line in lines {
                    if line.contains("#") || line.trimmingCharacters(in: .whitespaces).isEmpty {
                        continue
                    }

                    let components = line.components(separatedBy: "|")
                    if components.count == 5,
                       let amount = Double(components[2]),
                       let rate = Double(components[4].replacingOccurrences(of: ",", with: ".")) {

                        let code = components[3]
                        let valuePerUnit = rate / amount
                        results.append(CurrencyEntry(code: code, rate: valuePerUnit))
                    }
                }
            
            return results
            
        } catch {
            print("Request Failed")
            throw NetworkError.requestFailed(error)
        }
    }
}


//21 Jul 2025 #139
//Country|Currency|Amount|Code|Rate
//Australia|dollar|1|AUD|13.765
//Brazil|real|1|BRL|3.780
//Bulgaria|lev|1|BGN|12.588
//Canada|dollar|1|CAD|15.397
//China|renminbi|1|CNY|2.940
//Denmark|krone|1|DKK|3.298
//EMU|euro|1|EUR|24.620
//Hongkong|dollar|1|HKD|2.688
//Hungary|forint|100|HUF|6.172
//Iceland|krona|100|ISK|17.289
//IMF|SDR|1|XDR|28.816
//India|rupee|100|INR|24.459
//Indonesia|rupiah|1000|IDR|1.294
//Israel|new shekel|1|ILS|6.291
//Japan|yen|100|JPY|14.311
//Malaysia|ringgit|1|MYR|4.982
//Mexico|peso|1|MXN|1.131
//New Zealand|dollar|1|NZD|12.602
//Norway|krone|1|NOK|2.075
//Philippines|peso|100|PHP|36.909
//Poland|zloty|1|PLN|5.803
//Romania|leu|1|RON|4.856
//Singapore|dollar|1|SGD|16.471
//South Africa|rand|1|ZAR|1.192
//South Korea|won|100|KRW|1.524
//Sweden|krona|1|SEK|2.196
//Switzerland|franc|1|CHF|26.401
//Thailand|baht|100|THB|65.326
//Turkey|lira|100|TRY|52.245
//United Kingdom|pound|1|GBP|28.442
//USA|dollar|1|USD|21.100
