//
//  GetScaleTodayIdUseCase.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

import Foundation

class GetScaleTodayIdUseCase: GetScaleTodayIdUseCaseProtocol {
    var annualScaleUseCase: AnnualScaleUseCaseProtocol
    
    init(annualScaleUseCase: AnnualScaleUseCaseProtocol) {
        self.annualScaleUseCase = annualScaleUseCase
    }
    
    func execute() -> Int {
        let now = Date.now
        let year = Calendar.current.component(.year, from: now)
        
        let annualScale = try? annualScaleUseCase.execute(with: year)
        for weekScale in annualScale ?? [] {
            if isSameWeek(startWeek: weekScale.date) {
                return weekScale.scale
            }
        }
        
        return 1
    }
    
    private func isSameWeek(startWeek: Date) -> Bool {
        let now = Date.now
        let distance = startWeek.distance(to: now)
        if (startWeek.compare(now) == .orderedSame || startWeek.compare(now) == .orderedAscending)
            && lessThanOneWeek(distance) {
            return true
        }
        return false
    }
    
    private func lessThanOneWeek(_ distance: TimeInterval) -> Bool {
        return distance < 604800
    }
}
