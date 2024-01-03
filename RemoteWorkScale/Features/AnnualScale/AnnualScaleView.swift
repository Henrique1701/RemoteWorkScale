//
//  AnnualScaleView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 02/01/24.
//

import SwiftUI

struct AnnualScaleView: View {
    let viewModel = AnnualScaleViewModel(annualScaleUseCase: AnnualScaleUseCase())
    
    // TODO: criar inicializador
    
    var body: some View {
        VStack {
            HStack {
                Text("Escala anual")
                    .font(.title)
                Spacer()
                // TODO: Adicionar filtro por ano
            }
            .padding()
            TableView(models: .constant(viewModel.getTableModels()))
        }
    }
}

#Preview {
    AnnualScaleView()
}
