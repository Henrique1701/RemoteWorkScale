//
//  RemoteWorkScaleApp.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 26/11/23.
//

import SwiftUI

@main
struct RemoteWorkScaleApp: App {
    @StateObject var collaboratorsModel = CollaboratorsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collaboratorsModel)
        }
    }
}
