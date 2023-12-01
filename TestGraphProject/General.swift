//
//  General.swift
//  TestGraphProject
//
//  Created by Oleh on 01.12.2023.
//

import Foundation

enum MoodCondition: Double, CaseIterable {
    case terrible = 0
    case usual
    case good
    case excellent
    
    var name: String {
        switch self {
        case .terrible: "Terrible"
        case .usual: "Usual"
        case .good: "Good"
        case .excellent: "Excellent"
        }
    }
    
    static var statusList: [String] {
        return MoodCondition.allCases.map { $0.name }
    }
}


enum WeekDay: String, CaseIterable {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturnday = "Sat"
    case sunday = "Sun"
}

