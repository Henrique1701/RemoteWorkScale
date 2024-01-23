//
//  RemoveCollaboratorViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import Combine

class RemoveCollaboratorViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published var collaboratorsModel: CollaboratorsModel
    
    @Published var collaborators = [String]()
    @Published var selectedCollaborator = ""
    @Published var showAlert = false
    
    // MARK: - PRIVATE PROPERTIES
    
    private var alertMessage = ""
    
    // MARK: - INITIALIZER
    
    init(collaboratorsModel: CollaboratorsModel) {
        self.collaboratorsModel = collaboratorsModel
        setCollaboratorsAndFirstSelectedCollaborator()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setCollaboratorsAndFirstSelectedCollaborator() {
        collaborators = collaboratorsModel.collaborators.map { $0.name }
        selectedCollaborator = collaborators.first ?? ""
    }
    
    // MARK: - PUBLIC METHODS
    
    func removeSelectedCollaborator() {
        do {
            try collaboratorsModel.removeCollaborator(with: selectedCollaborator)
            alertMessage = "\(selectedCollaborator) removido com sucesso!"
            setCollaboratorsAndFirstSelectedCollaborator()
        } catch {
            alertMessage = "Error ao tentar remover o colaborador \(selectedCollaborator)"
        }
        
        showAlert = true
    }
    
    func getAlertMessage() -> String {
        return alertMessage
    }
}

