//
//  EditScaleRow.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 14/01/24.
//

import SwiftUI

struct EditScaleRow: View {
    var weekday: Weekday
    
    @Binding var workplace: WorkplaceType
    
    private var workplaceTypes: [WorkplaceType] {
        [.company, .home]
    }
    
    var body: some View {
        HStack {
            Text(weekday.rawValue.lowercased())
            Spacer()
            Picker("", selection: $workplace) {
                ForEach(workplaceTypes, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }
}

#Preview {
    EditScaleRow(weekday: .monday, workplace: .constant(.home))
}
