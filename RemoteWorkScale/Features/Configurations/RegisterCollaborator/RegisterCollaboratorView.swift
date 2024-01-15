//
//  RegisterCollaboratorView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 13/01/24.
//

import SwiftUI

struct RegisterCollaboratorView: View {
    
    @State private var collaboratorName = ""
    
    @ObservedObject var viewModel = RegisterCollaboratorViewModel(registerCollaboratorUseCase: RegisterCollaboratorUseCase(service: ServiceLocal()))
    
    var body: some View {
        VStack {
            Text("Adicionar novo colaborador")
            TextField("Nome do colaborador",
                      text: $collaboratorName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Button("Adicionar") {
                viewModel.registerNewCollaborator(with: collaboratorName)
            }
            .alert(Text(viewModel.alertMessage),
                   isPresented: $viewModel.showAlert) {
                Button("Fechar", role: .cancel) { }
            }
        }
    }
}

#Preview {
    RegisterCollaboratorView()
}
