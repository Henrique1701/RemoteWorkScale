//
//  ServiceProtocol.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/12/23.
//

protocol ServiceProtocol {
    func getCollaborators() -> [Collaborator]
    func add(collaborator: Collaborator) throws
    func edit(collaborator: Collaborator) throws
    func removeCollaborator(with name: String) throws
    func editCollaboratorName(from name: String, to newName: String) throws
}
