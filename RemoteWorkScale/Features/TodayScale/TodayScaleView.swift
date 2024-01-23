//
//  TodayScaleView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

import Combine
import SwiftUI

struct TodayScaleView: View {
    @ObservedObject var viewModel: TodayScaleViewModel
    
    init(_ viewModel: TodayScaleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "Escala de hoje",
                       subtitle: "A escala de hoje é a: \(viewModel.getScaleTodayId())",
                       filterIsOn: $viewModel.filterIsOn)
            
            if viewModel.filterIsOn {
                HStack {
                    Text("Selecionar colaborador")
                    Picker("Selecionar Visualização", selection: $viewModel.collaborator) {
                        List {
                            
                        }
                        ForEach(viewModel.collaboratorsModel.collaborators, id:\.self) {
                            Text("\($0.name)")
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)
            }
            
            TableView(models: $viewModel.tableModels)
        }
        .onAppear {
            viewModel.viewAppear()
        }
        .onChange(of: viewModel.filterIsOn) {
            viewModel.filterIsOnWasUpdated()
        }
    }
}

#Preview {
    TodayScaleView(
        TodayScaleViewModel(
        collaboratorsModel: CollaboratorsModel(),
        getScaleTodayIdUseCase: GetScaleTodayIdUseCase(annualScaleUseCase: AnnualScaleUseCase())
    ))
}
