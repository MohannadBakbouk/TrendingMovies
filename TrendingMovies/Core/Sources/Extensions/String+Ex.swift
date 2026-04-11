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
}
