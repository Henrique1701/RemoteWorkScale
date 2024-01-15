//
//  TodayScaleView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 05/12/23.
//

import Combine
import SwiftUI

struct TodayScaleView<ViewModel: TodayScaleViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Escala de hoje")
                        .font(.title)
                    Text("A escala de hoje é: \(viewModel.getScaleTodayId())")
                        .font(.subheadline)
                }
                Spacer()
                Toggle("Filtrar", isOn: $viewModel.filterIsOn)
                    .toggleStyle(.button)
            }
            .padding()
            
            if viewModel.filterIsOn {
                HStack {
                    Text("Selecionar colaborador")
                    Picker("Selecionar Visualização", selection: $viewModel.collaborator) {
                        ForEach(viewModel.collaborators, id:\.self) {
                            Text("\($0.name)")
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)
            }
            
            TableView(models: .constant(viewModel.getTableModel()))
        }
        .onAppear {
            viewModel.updateCollaborator()
        }
    }
}

#Preview {
    TodayScaleView(viewModel: TodayScaleViewModel(
        getScaleTodayIdUseCase: GetScaleTodayIdUseCase(annualScaleUseCase: AnnualScaleUseCase()),
        getAllCollaboratorsUseCase: GetAllCollaboratorsUseCase(service: ServiceLocal())
    ))
}
