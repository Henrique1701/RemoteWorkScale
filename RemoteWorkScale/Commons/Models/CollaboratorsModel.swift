//
//  CollaboratorsModel.swift
//  RemoteWorkScale
//
//  Created by José Henrique Fernandes Silva on 22/01/24.
//

import Combine
import Foundation

class CollaboratorsModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published var collaborators = [Collaborator]()
    
    // MARK: - PRIVATE PROPERTIES
    
    private let fileName = "collaborators.json"
    private let jsonUrl = Bundle.main.url(forResource: "collaborators", withExtension: "json")
    private var alreadyCopiedJson: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "alreadyCopiedJson")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "alreadyCopiedJson")
        }
    }
    
    // MARK: - INITIALIZER
    
    init() {
        try? copyJsonFileToDocumentsFolder(fileName: fileName)
        collaborators = getCollaborators()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func write(_ collaborators: [Collaborator]) throws {
        let data = try JSONEncoder().encode(collaborators)
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL, options: .atomicWrite)
        } catch {
            throw ServiceError.write
        }
    }
    
    private func read(filename: String) throws -> [Collaborator] {
        do {
            let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
            let data = try Data(contentsOf: file)
            
            let decoder = JSONDecoder()
            return try decoder.decode([Collaborator].self, from: data )
        } catch {
            throw ServiceError.read
        }
    }
    
    private func copyJsonFileToDocumentsFolder(fileName: String) throws {
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        if alreadyCopiedJson { return }
        
        guard let jsonUrl else { throw ServiceError.copy }
        
        do {
            let destURL = documentsURL.appendingPathComponent(fileName)
            try FileManager.default.copyItem(at: jsonUrl, to: destURL)
            alreadyCopiedJson = true
        } catch {
            throw ServiceError.write
        }
    }
    
    // MARK: - PUBLIC METHODS
    
    func getCollaborators() -> [Collaborator] {
        do {
            return try read(filename: fileName)
        } catch {
            return []
        }
    }
    
    func add(collaborator: Collaborator) throws {
        var collaborators = getCollaborators()
        if !collaborators.contains(where: { $0.name == collaborator.name }) {
            collaborators.append(collaborator)
        }
        
        do {
            try write(collaborators)
            self.collaborators = getCollaborators()
        } catch {
            throw ServiceError.message("Error ao adicionar o colaborador \(collaborator.name)")
        }
    }
    
    func edit(collaborator: Collaborator) throws {
        var collaborators = getCollaborators()
        guard let index = collaborators.firstIndex(where: {$0.name == collaborator.name}) else { return }
        
        collaborators[index] = collaborator
        
        try write(collaborators)
        self.collaborators = getCollaborators()
    }
    
    func removeCollaborator(with name: String) throws {
        var collaborators = getCollaborators()
        collaborators.removeAll(where: { $0.name == name })
        
        try write(collaborators)
        self.collaborators = getCollaborators()
    }
    
    func editCollaboratorName(from name: String, to newName: String) throws {
        var collaborators = getCollaborators()
        let index = collaborators.firstIndex(where: {
            $0.name == name
        })
        
        let nameAlreadyExists = collaborators.reduce(false) { partialResult, collaborator in
            return partialResult || collaborator.name == newName
        }
        if nameAlreadyExists {
            throw ServiceError.editCollaboratorNomeAlreadyExists
        }
        
        guard let index else {
            throw ServiceError.editCollaboratorNome
        }
        
        collaborators[index].name = newName
        try write(collaborators)
        self.collaborators = getCollaborators()
    }
}
