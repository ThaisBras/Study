//
//  CoreDataStack.swift
//  Study
//
//  Created by Thais da Silva Bras on 29/07/21.
//

import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    private let model: String

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.model)
        let defaultURL = NSPersistentContainer.defaultDirectoryURL()
        let sqliteURL = defaultURL.appendingPathComponent("\(self.model).sqlite")

        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error.localizedDescription)")
            }
        }

        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    private init(model: String = "Study") {
        self.model = model
    }

    func save() throws {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                throw CoreDataStackError.failedToSave
            }
        } else {
            throw CoreDataStackError.contextHasNoChanges
        }
    }
    
    func createSubject(name: String) throws -> Subject {
        let subject = Subject(context: mainContext)
        
        subject.name = name
        
        try save()
        
        return subject
    }
    
    func deleteSubject(subject: Subject) throws {
        mainContext.delete(subject)
        
        try save()
    }
    
    func createToDo(name: String, date: Date, subject: Subject) throws {
        let toDo = ToDo(context: mainContext)
        
        toDo.name = name
        toDo.finishDate = date
        subject.addToToDos(toDo)
        try save()
    }
    
    
}

enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}
