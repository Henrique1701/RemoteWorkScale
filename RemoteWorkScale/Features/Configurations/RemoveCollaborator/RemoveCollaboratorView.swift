//
//  RemoveCollaboratorView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 13/01/24.
//

import SwiftUI

struct RemoveCollaboratorView: View {
    @State private var collaborator = ""
    @State private var showRemoveConfirmationAlert = false
    
    @StateObject private var viewModel = RemoveCollaboratorViewModel(
        getAllCollaboratorsUseCase: GetAllCollaboratorsUseCase(service: ServiceLocal()),
        removeCollaboratorUseCase: RemoveCollaboratorUseCase(service: ServiceLocal())
    )
    
    var body: some View {
        VStack {
            HStack {
                Text("Remover colaborador")
                Picker("", selection: $viewModel.selectedCollaborator) {
                    ForEach(viewModel.collaborators, id:\.self) {
                        Text($0)
                    }
                }
            }
            .padding(.horizontal)
            
            Button("Remover") {
                showRemoveConfirmationAlert = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert("Deseja remover o colaborador: \(viewModel.selectedCollaborator)", isPresented: $showRemoveConfirmationAlert) {
                Button("Cancelar", role: .cancel) { }
                Button("Remover", role: .destructive) {
                    viewModel.removeSelectedCollaborator()
                }
            }
            .alert(viewModel.getAlertMessage(),
                   isPresented: $viewModel.showAlert) {
                Button("Fechar", role: .cancel) { }
            }
                   
        }
    }
}

#Preview {
    RemoveCollaboratorView()
}
