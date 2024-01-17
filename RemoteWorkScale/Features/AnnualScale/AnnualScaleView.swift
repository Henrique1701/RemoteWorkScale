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
            HeaderView(title: "Escala anual")
            List {
                HStack {
                    Text(viewModel.getTableModels().first?.leftDescription ?? "")
                        .font(.headline)
                    Spacer()
                    Text(viewModel.getTableModels().first?.rightDescription ?? "")
                        .font(.headline)
                        .padding(.trailing)
                }
                ForEach(viewModel.getTableModels().first?.rows ?? [], id: \.self) { row in
                    HStack {
                        Text(row.left)
                        Spacer()
                        Text(row.right)
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    AnnualScaleView()
}
