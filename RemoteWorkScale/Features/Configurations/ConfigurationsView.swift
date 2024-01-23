//
//  ConfigurationsView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 03/01/24.
//

import SwiftUI

enum ConfigurationViewSelection {
    case register
    case edit
    case remove
    case editCollaboratorName
}

struct ConfigurationsView: View {
    
    @EnvironmentObject var collaboratorsModel: CollaboratorsModel
    
    var body: some View {
        VStack {
            HeaderView(title: "Configurações")
            List {
                NavigationLink("Cadastrar colaborador", value: ConfigurationViewSelection.register)
                NavigationLink("Remover colaborador", value: ConfigurationViewSelection.remove)
                NavigationLink("Editar escala", value: ConfigurationViewSelection.edit)
                NavigationLink("Editar nomes", value: ConfigurationViewSelection.editCollaboratorName)
            }
            .navigationDestination(for: ConfigurationViewSelection.self) { selection in
                switch selection {
                case .register: RegisterCollaboratorView(viewModel: RegisterCollaboratorViewModel(collaboratorsModel: collaboratorsModel))
                case .edit: EditScaleView(viewModel: EditScaleViewModel(collaboratorsModel: collaboratorsModel))
                case .remove: RemoveCollaboratorView(viewModel: RemoveCollaboratorViewModel(collaboratorsModel: collaboratorsModel))
                case .editCollaboratorName: EditCollaboratorNameView(viewModel: EditCollaboratorNameViewModel(collaboratorsModel: collaboratorsModel))
                }
            }
        }
    }
}

#Preview {
    ConfigurationsView()
}
