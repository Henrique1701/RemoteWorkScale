//
//  TableView.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import SwiftUI

struct TableModel: Hashable {
    var title: String
    var leftDescription: String?
    var rightDescription: String?
    var rows: [RowInformation]
    
    init(title: String = "",
         leftDescription: String? = nil,
         rightDescription: String? = nil,
         rows: [RowInformation] = []) {
        self.title = title
        self.leftDescription = leftDescription
        self.rightDescription = rightDescription
        self.rows = rows
    }
}

struct TableView: View {
    @Binding var models: [TableModel]
    var hasMultipleSections: Bool {
        return models.count > 1
    }
    
    var body: some View {
        List {
            ForEach(models, id: \.self) { model in
                Section("\(model.title)") {
                    if model.leftDescription != nil || model.rightDescription != nil {
                        HeaderRow(leftDescription: model.leftDescription,
                                  rightDescription: model.rightDescription)
                    }
                    ForEach(model.rows) { rowInfo in
                        ContentRow(leftInfo: rowInfo.left,
                                   rightInfo: rowInfo.right)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    TableView(models: .constant([
        TableModel(title: "Nome",
                       leftDescription: "Dia da semana",
                       rightDescription: "Local de trabalho",
                       rows: [
                        RowInformation(left: "segunda", right: "presencial"),
                        RowInformation(left: "terça  ", right: "presencial"),
                        RowInformation(left: "quarta ", right: "casa"),
                        RowInformation(left: "quinta ", right: "presencial"),
                        RowInformation(left: "sexta  ", right: "casa"),
                       ]),
        TableModel(title: "Nome2",
                       leftDescription: "Dia da semana",
                       rightDescription: "Local de trabalho",
                       rows: [
                        RowInformation(left: "segunda", right: "presencial"),
                        RowInformation(left: "terça  ", right: "casa"),
                        RowInformation(left: "quarta ", right: "casa"),
                        RowInformation(left: "quinta ", right: "presencial"),
                        RowInformation(left: "sexta  ", right: "casa"),
                       ])
    ]))
}

#Preview {
    TableView(models: .constant([.init(
        title: "Nome",
        leftDescription: "Início da semana",
        rightDescription: "Escala",
        rows: [
            RowInformation(left: "01/01/2024", right: "1"),
            RowInformation(left: "08/01/2024", right: "2"),
            RowInformation(left: "15/01/2024", right: "3"),
            RowInformation(left: "22/01/2024", right: "4"),
            RowInformation(left: "29/01/2024", right: "5")
        ]
    )]))
}
