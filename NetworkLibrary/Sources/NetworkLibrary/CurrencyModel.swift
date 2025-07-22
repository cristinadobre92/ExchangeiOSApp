import Foundation

public struct CurrencyEntry: Identifiable, Sendable, Hashable {
    public let id = UUID()
    public var code: String
    public let rate: Double
}
