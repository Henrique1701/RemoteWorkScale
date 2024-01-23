//
//  EditCollaboratorNameViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

import Combine

class EditCollaboratorNameViewModel: ObservableObject {
    @Published var collaboratorsModel: CollaboratorsModel
    @Published var showAlert = false
    @Published var selectedCollaboratorName = ""
    @Published var newName = ""
    
    private var alertMessage = ""
    private var collaboratorNames: [String] {
        collaboratorsModel.collaborators.map { $0.name }
    }
    
    init(collaboratorsModel: CollaboratorsModel) {
        self.collaboratorsModel = collaboratorsModel
        setProperties()
    }
    
    private func setProperties() {
        selectedCollaboratorName = getCollaboratorNames().first ?? ""
    }
    
    private func updateSelectedCollaboratorName() {
        selectedCollaboratorName = collaboratorNames.first ?? ""
    }
    
    private func getAlertMessageError(_ error: Error) -> String {
        if let error = error as? ServiceError,
           case .editCollaboratorNomeAlreadyExists = error {
            return "O nome não foi editado pois já existe um colaborador com o nome \(newName)"
        }
        return "Erro ao alterar o nome do colaborador"
    }
    
    func editCollaboratorName() {
        do {
            try collaboratorsModel.editCollaboratorName(from: selectedCollaboratorName, to: newName)
            alertMessage = "Nome alterado com sucesso!"
            updateSelectedCollaboratorName()
        } catch(let error) {
            alertMessage = getAlertMessageError(error)
        }
        
        showAlert = true
    }
    
    func getCollaboratorNames() -> [String] {
        return collaboratorNames
    }
    
    func getAlertMessage() -> String {
        return alertMessage
    }
}
