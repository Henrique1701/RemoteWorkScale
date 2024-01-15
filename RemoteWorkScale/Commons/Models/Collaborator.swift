//
//  Collaborator.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

struct Collaborator: Codable {
    var name: String
    var scales: [Scale]
    
    private static let defaultScales: [Scale] = [
        .init(id: 1),
        .init(id: 2),
        .init(id: 3),
        .init(id: 4),
        .init(id: 5)
    ]
    
    init(name: String = "",
         scales: [Scale] = defaultScales) {
        self.name = name
        self.scales = scales
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case scales = "escalas"
    }
}

extension Collaborator: Hashable {
    static func == (lhs: Collaborator, rhs: Collaborator) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
