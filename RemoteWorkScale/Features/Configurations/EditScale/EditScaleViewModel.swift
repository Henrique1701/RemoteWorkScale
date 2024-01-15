//
//  EditScaleViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import Combine

class EditScaleViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published var selectedCollaborator: Collaborator = .init()
    @Published var selectedScaleId = 1
    @Published var showAlert = false
    
    @Published var mondayWorkplace: WorkplaceType = .company
    @Published var tuesdayWorkplace: WorkplaceType = .company
    @Published var wednesdayWorkplace: WorkplaceType = .company
    @Published var thursdayWorkplace: WorkplaceType = .company
    @Published var fridayWorkplace: WorkplaceType = .company
    
    // MARK: - PRIVATE PROPERTIES
    
    private let editCollaboratorUseCase: EditCollaboratorUseCaseProtocol
    private let getAllCollaboratorUseCase: GetAllCollaboratorsUseCaseProtocol
    private var collaborators = [Collaborator]()
    private var alertMessage = ""
    
    // MARK: - INITIALIZATER
    
    init(editCollaboratorUseCase: EditCollaboratorUseCaseProtocol,
         getAllCollaboratorUseCase: GetAllCollaboratorsUseCaseProtocol) {
        self.editCollaboratorUseCase = editCollaboratorUseCase
        self.getAllCollaboratorUseCase = getAllCollaboratorUseCase
        setupProperties()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupProperties() {
        collaborators = getAllCollaboratorUseCase.execute()
        selectedCollaborator = collaborators.first ?? .init()
    }
    
    private func getCurrentSelectedScale() -> Scale? {
        return selectedCollaborator.scales.first(where: {
            $0.id == selectedScaleId
        })
    }
    
    private func getSelectedScaleIndex() -> Int? {
        return selectedCollaborator.scales.firstIndex {
            $0.id == selectedScaleId
        }
    }
    
    private func getEditedCollaborator() -> Collaborator {
        guard let index = getSelectedScaleIndex() else {
            return selectedCollaborator
        }
        var editedCollaborator = selectedCollaborator
        editedCollaborator.scales[index] = Scale(
            id: selectedScaleId,
            monday: mondayWorkplace,
            tuesday: tuesdayWorkplace,
            wednesday: wednesdayWorkplace,
            thursday: thursdayWorkplace,
            friday: fridayWorkplace
        )
        return editedCollaborator
    }
    
    // MARK: - PUBLIC METHODS
    
    func getCollaboratorsName() -> [String] {
        return getAllCollaboratorUseCase.execute().map { $0.name }
    }
    
    func getCollaborators() -> [Collaborator] {
        return getAllCollaboratorUseCase.execute()
    }
    
    func editCollaborator() {
        let editedCollaborator = getEditedCollaborator()
        do {
            try editCollaboratorUseCase.execute(with: editedCollaborator)
            alertMessage = "Sucesso ao editar as escalas!"
        } catch {
            alertMessage = "Erro ao editar as escalas"
        }
        showAlert = true
    }
    
    func getAllScalesId() -> [Int] {
        return [1, 2, 3, 4]
    }
    
    func getWorkplaceTypes() -> [WorkplaceType] {
        return [.company, .home]
    }
    
    func updateWeekdayWorkplaces() {
        guard let scale = getCurrentSelectedScale() else { return }
        mondayWorkplace = scale.monday
        tuesdayWorkplace = scale.tuesday
        wednesdayWorkplace = scale.wednesday
        thursdayWorkplace = scale.thursday
        fridayWorkplace = scale.friday
    }
    
    func getAlertMessage() -> String {
        return alertMessage
    }
}
