//
//  ServiceLocal.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/12/23.
//

import Foundation

class ServiceLocal: ServiceProtocol {
    
    let jsonUrl = Bundle.main.url(forResource: "collaborators", withExtension: "json")
    
    func getCollaborators() -> [Collaborator] {
        guard let jsonUrl else { return [] }
        var collaborators = [Collaborator]()
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            collaborators = try JSONDecoder().decode([Collaborator].self, from: jsonData)
        } catch {
            return []
        }
        
        return collaborators
    }
}
