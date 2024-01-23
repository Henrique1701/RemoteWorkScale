//
//  RegisterCollaboratorViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import Combine
import Foundation

class RegisterCollaboratorViewModel: ObservableObject {
    @Published var collaboratorsModel: CollaboratorsModel
    @Published var selectedCollaboratorName = ""
    @Published var showAlert = false
    var alertMessage = ""
    
    init(collaboratorsModel: CollaboratorsModel) {
        self.collaboratorsModel = collaboratorsModel
    }
    
    func registerNewCollaborator() {
        let newName = selectedCollaboratorName.isEmpty ? UUID().uuidString : selectedCollaboratorName
        let newCollaborator = Collaborator(name: newName)
        
        selectedCollaboratorName = ""
        alertMessage = ""
        
        do {
            try collaboratorsModel.add(collaborator: newCollaborator)
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
