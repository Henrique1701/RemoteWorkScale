//
//  RemoveCollaboratorUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

class RemoveCollaboratorUseCase: RemoveCollaboratorUseCaseProtocol {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func execute(with collaboratorName: String) throws {
        try service.removeCollaborator(with: collaboratorName)
    }
}
