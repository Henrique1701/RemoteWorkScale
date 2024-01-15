//
//  ContentView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayScaleView(viewModel: TodayScaleViewModel())
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
