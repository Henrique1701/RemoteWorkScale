//
//  TodayScaleViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import Combine
import Foundation

protocol TodayScaleViewModelProtocol: ObservableObject {
    var collaborator: Collaborator { get set }
    var collaborators: [Collaborator] { get set }
    var filterIsOn: Bool { get set }
    var tableModels: [TableModel] { get set }
    
    func getScaleTodayId() -> Int
    func getScaleToday(to collaborator: Collaborator) -> Scale
    func getScaleTableData(from collaborator: Collaborator) -> [RowInformation]
    func getTableModel() -> [TableModel]
    
    func updateCollaborator()
}

class TodayScaleViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published var collaboratorsModel: CollaboratorsModel
    @Published var collaborator = Collaborator()
    @Published var filterIsOn = UserDefaults.standard.bool(forKey: "todayScaleFilterIsOn")
    @Published var tableModels = [TableModel]()
    
    // MARK: - PRIVATE PROPERTIES
    
    private let getScaleTodayIdUseCase: GetScaleTodayIdUseCaseProtocol
    
    // MARK: - INITIALIZETER
    
    init(collaboratorsModel: CollaboratorsModel,
         getScaleTodayIdUseCase: GetScaleTodayIdUseCaseProtocol) {
        self.collaboratorsModel = collaboratorsModel
        self.getScaleTodayIdUseCase = getScaleTodayIdUseCase
        
        updateSelectedCollaborator()
        updateTableModels()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func updateSelectedCollaborator() {
        collaborator = collaboratorsModel.collaborators.first ?? .init()
    }
    
    private func updateTableModels() {
        tableModels = getTableModel()
    }
    
    private func getWorkplace(_ scale: Scale, to day: Weekday) -> WorkplaceType {
        switch day {
        case .monday: scale.monday
        case .tuesday: scale.tuesday
        case .wednesday: scale.wednesday
        case .thursday: scale.thursday
        case .friday: scale.friday
        }
    }
    
    // MARK: - PUBLIC METHODS
    
    func getScaleTodayId() -> Int {
        return getScaleTodayIdUseCase.execute()
    }
    
    func getScaleToday(to collaborator: Collaborator) -> Scale {
        let scaleTodayId = getScaleTodayId()
        
        for scale in collaborator.scales where scale.id == scaleTodayId {
            return scale
        }
        
        return .init(id: -1)
    }
    
    func getScaleTableData(from collaborator: Collaborator) -> [RowInformation] {
        let scaleToday = getScaleToday(to: collaborator)
        var data = [RowInformation]()
        
        for day in Weekday.getWeekdays() {
            let workplace = getWorkplace(scaleToday, to: day)
            data.append(.init(left: day.rawValue,
                              right: workplace.rawValue))
        }
        
        return data
    }
    
    func getTableModel() -> [TableModel] {
        if filterIsOn {
            return [
                .init(title: "",
                      leftDescription: "Dia da semana",
                      rightDescription: "Local de trabalho",
                      rows: getScaleTableData(from: collaborator))
            ]
        }
        
        var models = [TableModel]()
        for collaborator in collaboratorsModel.collaborators {
            models.append(
                .init(title: collaborator.name,
                      leftDescription: "Dia da semana",
                      rightDescription: "Local de trabalho",
                      rows: getScaleTableData(from: collaborator))
            )
        }
        return models
    }
    
    func viewAppear() {
        updateSelectedCollaborator()
        updateTableModels()
    }
    
    func filterIsOnWasUpdated() {
        UserDefaults.standard.set(filterIsOn, forKey: "todayScaleFilterIsOn")
        updateTableModels()
    }
}
