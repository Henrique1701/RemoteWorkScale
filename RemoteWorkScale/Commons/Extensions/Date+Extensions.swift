//
//  Date+Extensions.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 03/01/24.
//

import Foundation

extension Date {
    mutating func addOneWeek() {
        let weekInSeconds = 604800
        self = self.addingTimeInterval(.init(weekInSeconds))
    }
}
