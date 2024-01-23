//
//  EditCollaboratorNameView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import SwiftUI

struct EditCollaboratorNameView: View {
    
    @ObservedObject var viewModel: EditCollaboratorNameViewModel
    
    init(viewModel: EditCollaboratorNameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Selecione o colaborador")
                Picker("", selection: $viewModel.selectedCollaboratorName) {
                    ForEach(viewModel.getCollaboratorNames(), id: \.self) {
                        Text($0)
                    }
                }
            }
            TextField("Novo nome", text: $viewModel.newName)
                .textFieldStyle(.roundedBorder)
            Button("Editar nome") {
                viewModel.editCollaboratorName()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(viewModel.getAlertMessage(),
                   isPresented: $viewModel.showAlert) {
                Button("Fechar", role: .cancel) { }
            }
        }
        .padding()
    }
}

#Preview {
    EditCollaboratorNameView(viewModel: EditCollaboratorNameViewModel(collaboratorsModel: CollaboratorsModel()))
}
