//
//  EditCollaboratorNameUseCaseProtocol.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

protocol EditCollaboratorNameUseCaseProtocol {
    func execute(with name: String, and newName: String) throws
}
