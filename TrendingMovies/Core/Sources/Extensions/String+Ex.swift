//
//  String+Ex.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//
import Foundation

public extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
    
    static func currencyString(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1

        let number = Double(value)
        let abbreviated: Double
        let suffix: String

        switch number {
        case 1_000_000_000...:
            abbreviated = number / 1_000_000_000
            suffix = "B"
        case 1_000_000...:
            abbreviated = number / 1_000_000
            suffix = "M"
        case 1_000...:
            abbreviated = number / 1_000
            suffix = "K"
        default:
            abbreviated = number
            suffix = ""
        }

        let formatted = formatter.string(from: NSNumber(value: abbreviated)) ?? "\(abbreviated)"
        return "$\(formatted)\(suffix)"
    }
    
    var nilIfEmpty: String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
