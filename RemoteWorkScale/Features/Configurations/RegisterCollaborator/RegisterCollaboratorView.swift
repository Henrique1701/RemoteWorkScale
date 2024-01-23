//
//  RegisterCollaboratorView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 13/01/24.
//

import SwiftUI

struct RegisterCollaboratorView: View {
    @ObservedObject var viewModel: RegisterCollaboratorViewModel
    
    init(viewModel: RegisterCollaboratorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Adicionar novo colaborador")
            TextField("Nome do colaborador",
                      text: $viewModel.selectedCollaboratorName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Button("Adicionar") {
                viewModel.registerNewCollaborator()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(viewModel.alertMessage,
                   isPresented: $viewModel.showAlert) {
                Button("Fechar", role: .cancel) { }
            }
            Text(viewModel.alertMessage)
                .font(.callout)
                .padding()
        }
    }
}

#Preview {
    RegisterCollaboratorView(
        viewModel: RegisterCollaboratorViewModel(collaboratorsModel: CollaboratorsModel())
    )
}
