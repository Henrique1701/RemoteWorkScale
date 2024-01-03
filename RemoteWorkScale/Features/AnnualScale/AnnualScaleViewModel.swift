//
//  AnnualScaleViewModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 02/01/24.
//

import Combine

// TODO: Criar um protocolo para a view model
class AnnualScaleViewModel: ObservableObject {
    @Published var scaleDates = [ScaleDate]()
    
    let annualScaleUseCase: AnnualScaleUseCaseProtocol
    
    init(annualScaleUseCase: AnnualScaleUseCaseProtocol) {
        self.annualScaleUseCase = annualScaleUseCase
        initializeScaleDates()
    }
    
    private func initializeScaleDates() {
        do {
            // TODO: Pegar o ano atual
            scaleDates = try annualScaleUseCase.execute(with: 2024)
        } catch {
            scaleDates = []
        }
    }
    
    func getTableModels() -> [TableModel] {
        var rows = [RowInformation]()
        for scaleDate in scaleDates {
            rows.append(.init(left: scaleDate.date.formatted(date: .numeric, time: .omitted),
                              right: "\(scaleDate.scale)"))
        }
        
        return [
            .init(leftDescription: "Inicio da Semana",
                  rightDescription: "Escala",
                  rows: rows)
        ]
    }
}
