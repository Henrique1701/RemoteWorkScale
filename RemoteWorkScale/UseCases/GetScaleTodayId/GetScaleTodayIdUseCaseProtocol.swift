//
//  GetScaleTodayIdUseCaseProtocol.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

import Foundation

protocol GetScaleTodayIdUseCaseProtocol {
    var annualScaleUseCase: AnnualScaleUseCaseProtocol { get }
    
    func execute() -> Int
}
