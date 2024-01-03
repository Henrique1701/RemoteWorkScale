//
//  Collaborator.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

struct Collaborator: Codable {
    let name: String
    var scales: [Scale]
    
    init(name: String = "",
         scales: [Scale] = []) {
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
