//
//  TodayScaleViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import Combine

protocol TodayScaleViewModelProtocol: ObservableObject {
    var collaborator: Collaborator { get set }
    var collaborators: [Collaborator] { get set }
    var filterIsOn: Bool { get set }
    
    func getScaleTodayId() -> Int
    func getScaleToday(to collaborator: Collaborator) -> Scale
    func getScaleTableData(from collaborator: Collaborator) -> [RowInformation]
    func getTableModel() -> [TableModel]
    
    func updateCollaborator()
}

class TodayScaleViewModel: TodayScaleViewModelProtocol {
    @Published var collaborator = Collaborator()
    @Published var collaborators = [Collaborator]()
    @Published var filterIsOn = false
    
    private let getScaleTodayIdUseCase: GetScaleTodayIdUseCaseProtocol
    private let getAllCollaboratorsUseCase: GetAllCollaboratorsUseCaseProtocol
    
    init(getScaleTodayIdUseCase: GetScaleTodayIdUseCaseProtocol,
         getAllCollaboratorsUseCase: GetAllCollaboratorsUseCaseProtocol) {
        self.getScaleTodayIdUseCase = getScaleTodayIdUseCase
        self.getAllCollaboratorsUseCase = getAllCollaboratorsUseCase
        
        updateCollaborator()
    }
    
    func updateCollaborator() {
        collaborators = getAllCollaboratorsUseCase.execute()
        collaborator = collaborators.first ?? .init()
    }
    
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
        for collaborator in collaborators {
            models.append(
                .init(title: collaborator.name,
                      leftDescription: "Dia da semana",
                      rightDescription: "Local de trabalho",
                      rows: getScaleTableData(from: collaborator))
            )
        }
        return models
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
}
