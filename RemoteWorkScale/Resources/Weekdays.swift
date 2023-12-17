//
//  Weekdays.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

enum Weekday: String {
    case monday = "Segunda"
    case tuesday = "Terça"
    case wednesday = "Quarta"
    case thursday = "Quinta"
    case friday = "Sexta"
    
    static func getWeekdays() -> [Weekday] {
        return [
            .monday,
            .tuesday,
            .wednesday,
            .thursday,
            .friday
        ]
    }
}
