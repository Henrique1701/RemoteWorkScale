//
//  EditCollaboratorUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

class EditCollaboratorUseCase: EditCollaboratorUseCaseProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func execute(with collaborator: Collaborator) throws {
        try service.edit(collaborator: collaborator)
    }
}
