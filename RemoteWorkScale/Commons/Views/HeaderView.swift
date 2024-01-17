//
//  HeaderView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 17/01/24.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var subtitle: String?
    
    var filterIsOn: Binding<Bool>? = nil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            Spacer()
            if let filterIsOn {
                Toggle("Filtrar", isOn: filterIsOn)
                    .toggleStyle(.button)
            }
        }
        .padding()
    }
}


#Preview {
    HeaderView(title: "Title")
}
