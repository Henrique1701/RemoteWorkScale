//
//  RowInformation.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 08/12/23.
//

import Foundation

struct RowInformation: Identifiable, Hashable {
    var id = UUID()
    
    let left: String
    let right: String
}
