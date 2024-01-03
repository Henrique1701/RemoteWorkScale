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
//        setSegmentedControlAppearance()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Escala de hoje")
                    .font(.title)
                Spacer()
                Toggle("Filtrar", isOn: $viewModel.filterIsOn)
                    .toggleStyle(.button)
            }
            .padding()
            
            if viewModel.filterIsOn {
                Picker("Selecionar Visualização", selection: $viewModel.collaborator) {
                    ForEach(viewModel.collaborators, id:\.self) {
                        Text("\($0.name)")
                    }
                }
                .pickerStyle(.segmented)
                .padding([.horizontal, .bottom])
            } 
            
            TableView(models: .constant(viewModel.getTableModel()))
        }
    }
    
    private func setSegmentedControlAppearance() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.15)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue],
                                                               for: .selected)
    }
}

#Preview {
    TodayScaleView(viewModel: TodayScaleViewModel())
}
