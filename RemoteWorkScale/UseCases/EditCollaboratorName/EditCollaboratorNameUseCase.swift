//
//  EditCollaboratorNameUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

class EditCollaboratorNameUseCase: EditCollaboratorNameUseCaseProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func execute(with name: String, and newName: String) throws {
        try service.editCollaboratorName(from: name, to: newName)
    }
}
