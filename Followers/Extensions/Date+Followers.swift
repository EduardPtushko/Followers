//
//  Date+Followers.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.02.2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().day())
    }
}
