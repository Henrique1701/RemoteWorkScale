//
//  RegisterCollaboratorUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

class RegisterCollaboratorUseCase: RegisterCollaboratorUseCaseProtocol {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func execute(_ collaborator: Collaborator) throws {
        try service.add(collaborator: collaborator)
    }
}
