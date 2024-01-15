//
//  GetAllCollaboratorsUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

class GetAllCollaboratorsUseCase: GetAllCollaboratorsUseCaseProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func execute() -> [Collaborator] {
        return service.getCollaborators()
    }
}
