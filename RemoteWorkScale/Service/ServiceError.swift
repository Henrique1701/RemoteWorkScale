//
//  ServiceError.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 15/01/24.
//

enum ServiceError: Error {
    case message(String)
    case editCollaboratorNome
    case editCollaboratorNomeAlreadyExists
    case write
    case read
    case copy
}
