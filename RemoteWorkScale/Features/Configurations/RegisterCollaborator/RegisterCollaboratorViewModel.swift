//
//  RegisterCollaboratorViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import Combine
import Foundation

class RegisterCollaboratorViewModel: ObservableObject {
    @Published var showAlert = false
    var alertMessage = ""
    
    private let registerCollaboratorUseCase: RegisterCollaboratorUseCaseProtocol
    
    init(registerCollaboratorUseCase: RegisterCollaboratorUseCaseProtocol) {
        self.registerCollaboratorUseCase = registerCollaboratorUseCase
    }
    
    func registerNewCollaborator(with name: String) {
        let newName = name.isEmpty ? UUID().uuidString : name
        let newCollaborator = Collaborator(name: newName)
        
        
        do {
            try registerCollaboratorUseCase.execute(newCollaborator)
            alertMessage = "\(newName) foi registrado com sucesso!"
        } catch {
            if let error = error as? ServiceError,
               case .message(let message) = error {
               alertMessage = message
            } else {
                alertMessage = "Error ao registrar novo usuário"
            }
        }
        
        showAlert = true
    }
}
