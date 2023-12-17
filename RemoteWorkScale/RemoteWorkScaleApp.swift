//
//  RemoteWorkScaleApp.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 26/11/23.
//

import SwiftUI

@main
struct RemoteWorkScaleApp: App {
    
    let collaborators: [Collaborator] = [
        .init(name: "name 1", scales: [.init(id: 1, monday: .home), .init(id: 2, monday: .home), .init(id: 3)]),
        .init(name: "name 2", scales: [.init(id: 1), .init(id: 2), .init(id: 3)]),
        .init(name: "name 3", scales: [.init(id: 1), .init(id: 2), .init(id: 3)])
    ]
    
    var body: some Scene {
        WindowGroup {
            TodayScaleView(viewModel: TodayScaleViewModel())
//            TodayScaleView(viewModel: TodayScaleViewModel(collaborators: collaborators))
        }
    }
}
