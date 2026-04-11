//
//  Date+Ex.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

public extension Date {
    var yearString: String {
        let year = Calendar.current.component(.year, from: self)
        return String(year)
    }
}
