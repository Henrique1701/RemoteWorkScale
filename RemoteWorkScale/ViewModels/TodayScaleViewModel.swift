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
}

class TodayScaleViewModel: TodayScaleViewModelProtocol {
    @Published var collaborator: Collaborator
    @Published var collaborators: [Collaborator]
    @Published var filterIsOn: Bool = true
    
    let service: ServiceProtocol
    
    init() {
        service = ServiceLocal()
        
        let collaborators = service.getCollaborators()
        
        self.collaborators = collaborators
        self.collaborator = collaborators.first ?? Collaborator()
    }
    
    func getScaleTodayId() -> Int {
        // TODO: Pegar o id da escala de hoje
        return 1
    }
    
    func getScaleToday(to collaborator: Collaborator) -> Scale {
        let scaleTodayId = getScaleTodayId()
        
        for scale in collaborator.scales where scale.id == scaleTodayId {
            print("Escala: \(String(describing: scale.scalesWithDayDescription.first?.workplace))")
            return scale
        }
        
        return .init(id: -1)
    }
    
    func getScaleTableData(from collaborator: Collaborator) -> [RowInformation] {
        let scaleToday = getScaleToday(to: collaborator)
        var data = [RowInformation]()
        
        print("entrou: \(collaborator.name)")
        
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
