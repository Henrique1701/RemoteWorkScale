//
//  EditScaleView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 13/01/24.
//

import SwiftUI

struct EditScaleView: View {
    @StateObject private var viewModel = EditScaleViewModel(
        editCollaboratorUseCase: EditCollaboratorUseCase(service: ServiceLocal()),
        getAllCollaboratorUseCase: GetAllCollaboratorsUseCase(service: ServiceLocal())
    )
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Editar escalas de")
                        Picker("Selecione o colaborador", selection: $viewModel.selectedCollaborator) {
                            ForEach(viewModel.getCollaborators(), id: \.self) {
                                Text($0.name)
                            }
                        }
                    }
                    HStack {
                        Text("Selecione o id da escala")
                        Picker("Selecione o id da escala", selection: $viewModel.selectedScaleId) {
                            ForEach(viewModel.getAllScalesId(), id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                }
                Button("Editar") {
                    viewModel.editCollaborator()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .alert(viewModel.getAlertMessage(),
                       isPresented: $viewModel.showAlert) {
                    Button("Fechar", role: .cancel) { }
                }
            }
            List {
                HStack {
                    Text("Dia da semana")
                    Spacer()
                    Text("Local de trabalho")
                }
                .font(.headline)
                EditScaleRow(weekday: .monday, 
                             workplace: $viewModel.mondayWorkplace)
                EditScaleRow(weekday: .tuesday,
                             workplace: $viewModel.tuesdayWorkplace)
                EditScaleRow(weekday: .wednesday,
                             workplace: $viewModel.wednesdayWorkplace)
                EditScaleRow(weekday: .thursday,
                             workplace: $viewModel.thursdayWorkplace)
                EditScaleRow(weekday: .friday,
                             workplace: $viewModel.fridayWorkplace)
            }
        }
        .onChange(of: viewModel.selectedCollaborator) {
            viewModel.updateWeekdayWorkplaces()
        }
        .onChange(of: viewModel.selectedScaleId) {
            viewModel.updateWeekdayWorkplaces()
        }
    }
}

#Preview {
    EditScaleView()
}
