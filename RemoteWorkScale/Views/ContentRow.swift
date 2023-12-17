//
//  ContentRow.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import SwiftUI

struct ContentRow: View {
    @State var leftInfo: String
    @State var rightInfo: String
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(leftInfo.lowercased())
                    .font(.callout)
                Spacer()
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                HStack {
                    Text(rightInfo)
                }
            }
        }
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    ContentRow(leftInfo: "segunda", rightInfo: "presencial")
}
