//
//  ContentView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var collaboratorsModel: CollaboratorsModel
    
    var body: some View {
        TabView {
            TodayScaleView(
                TodayScaleViewModel(collaboratorsModel: collaboratorsModel,
                                    getScaleTodayIdUseCase: GetScaleTodayIdUseCase(annualScaleUseCase: AnnualScaleUseCase()))
            )
            .tabItem {
                Label("Hoje", systemImage: "calendar.day.timeline.left")
            }
            
            AnnualScaleView()
                .tabItem {
                    Label("Anual", systemImage: "calendar")
                }
            
            NavigationStack {
                ConfigurationsView()
            }
            .tabItem {
                Label("Configurações", systemImage: "gearshape")
            }
        }
    }
}

#Preview {
    ContentView()
}
