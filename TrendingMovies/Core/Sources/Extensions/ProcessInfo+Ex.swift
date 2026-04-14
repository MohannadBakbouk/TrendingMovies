//
//  ProcessInfo+Ex.swift
//  Core
//
//  Created by Mohannad on 14/04/2026.
//
import Foundation

public extension ProcessInfo{
    class var isTesting: Bool{
        ProcessInfo.processInfo.arguments.contains("-uitesting")
    }
}
