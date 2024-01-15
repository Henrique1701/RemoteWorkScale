//
//  EditCollaboratorNameViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

import Combine

class EditCollaboratorNameViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var selectedCollaboratorName = ""
    @Published var newName = ""
    
    private let editCollaboratorNameUseCase: EditCollaboratorNameUseCaseProtocol
    private let getAllCollaboratorsUseCase: GetAllCollaboratorsUseCase
    private var alertMessage = ""
    private var collaboratorNames: [String] {
        getAllCollaboratorsUseCase.execute().map { $0.name }
    }
    
    init(editCollaboratorNameUseCase: EditCollaboratorNameUseCaseProtocol,
         getAllCollaboratorsUseCase: GetAllCollaboratorsUseCase) {
        self.editCollaboratorNameUseCase = editCollaboratorNameUseCase
        self.getAllCollaboratorsUseCase = getAllCollaboratorsUseCase
        setupProperties()
    }
    
    private func setupProperties() {
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
            try editCollaboratorNameUseCase.execute(with: selectedCollaboratorName, and: newName)
            alertMessage = "Nome alterado com sucesso!"
            updateSelectedCollaboratorName()
        } catch(let error) {
            alertMessage = getAlertMessageError(error)
        }
        
        showAlert = true
    }
    
    func getCollaboratorNames() -> [String] {
        return getAllCollaboratorsUseCase.execute().map { $0.name }
    }
    
    func getAlertMessage() -> String {
        return alertMessage
    }
}
