//
//  HeaderRow.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import SwiftUI

struct HeaderRow: View {
    var title: String?
    var leftDescription: String?
    var rightDescription: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title {
                Text(title.capitalized)
                    .font(.title)
            }
            HStack(alignment: .center) {
                HStack {
                    if let leftDescription {
                        Text(leftDescription)
                            .font(.headline)
                            .bold()
                    } else if rightDescription != nil {
                        Text("")
                    }
                    Spacer()
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    HStack {
                        if let rightDescription {
                            Text(rightDescription)
                                .font(.headline)
                                .bold()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HeaderRow(title: "Nome",
              leftDescription: "Dia da semana",
              rightDescription: "Local de trabalho").frame(height: 100)
}
