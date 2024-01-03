//
//  Scale.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

import Foundation

struct Scale: Codable, Identifiable {
    let id: Int
    var monday: WorkplaceType
    var tuesday: WorkplaceType
    var wednesday: WorkplaceType
    var thursday: WorkplaceType
    var friday: WorkplaceType
    
    var scalesWithDayDescription: [ScaleWithDayDescription] {
        return [
            .init(weekday: .monday, workplace: monday.rawValue),
            .init(weekday: .tuesday, workplace: tuesday.rawValue),
            .init(weekday: .wednesday, workplace: wednesday.rawValue),
            .init(weekday: .thursday, workplace: thursday.rawValue),
            .init(weekday: .friday, workplace: friday.rawValue)
        ]
    }
    
    init(id: Int, 
         monday: WorkplaceType = .company,
         tuesday: WorkplaceType = .company,
         wednesday: WorkplaceType = .company,
         thursday: WorkplaceType = .company,
         friday: WorkplaceType = .company) {
        self.id = id
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case monday = "segunda"
        case tuesday = "terça"
        case wednesday = "quarta"
        case thursday = "quinta"
        case friday = "sexta"
    }
}

extension Scale {
    struct ScaleWithDayDescription: Identifiable {
        let id = UUID()
        
        let weekday: Weekday
        let workplace: String
    }
}
