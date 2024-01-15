//
//  RemoveCollaboratorViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import Combine

class RemoveCollaboratorViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published var collaborators = [String]()
    @Published var selectedCollaborator = ""
    @Published var showAlert = false
    
    // MARK: - PRIVATE PROPERTIES
    
    private let getAllCollaboratorsUseCase: GetAllCollaboratorsUseCaseProtocol
    private let removeCollaboratorUseCase: RemoveCollaboratorUseCaseProtocol
    private var alertMessage = ""
    
    // MARK: - INITIALIZER
    
    init(getAllCollaboratorsUseCase: GetAllCollaboratorsUseCaseProtocol, removeCollaboratorUseCase: RemoveCollaboratorUseCaseProtocol) {
        self.getAllCollaboratorsUseCase = getAllCollaboratorsUseCase
        self.removeCollaboratorUseCase = removeCollaboratorUseCase
        setCollaboratorsAndFirstSelectedCollaborator()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setCollaboratorsAndFirstSelectedCollaborator() {
        collaborators = getAllCollaboratorsUseCase.execute().map { $0.name }
        selectedCollaborator = collaborators.first ?? ""
    }
    
    // MARK: - PUBLIC METHODS
    
    func removeSelectedCollaborator() {
        do {
            try removeCollaboratorUseCase.execute(with: selectedCollaborator)
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

