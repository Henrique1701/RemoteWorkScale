//
//  AnnualScaleUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 02/01/24.
//

import Foundation

protocol AnnualScaleUseCaseProtocol {
    func execute(with year: Int) throws -> [ScaleDate]
}

class AnnualScaleUseCase: AnnualScaleUseCaseProtocol {
    func execute(with year: Int) throws -> [ScaleDate] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let initialDate = dateFormatter.date(from: "01/01/\(year)"),
              let finalDate = dateFormatter.date(from: "01/01/\(year + 1)") else {
            throw UseCaseError.dateError
        }
        
        var currentScale = 1
        var date = initialDate
        var scales = [ScaleDate]()
        
        while date.compare(finalDate) == .orderedAscending {
            scales.append(.init(date: date, scale: currentScale))
            nextScale(from: &currentScale)
            date.addOneWeek()
        }
        
        return scales
    }
    
    private func nextScale(from currentScale: inout Int) {
        if currentScale < 4 {
            return currentScale += 1
        }
        return currentScale = 1
    }
}
