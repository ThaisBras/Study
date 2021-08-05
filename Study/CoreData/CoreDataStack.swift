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
    
    func getSubjects() throws -> [Subject]
    {
        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Subject.name, ascending: false)]

        return try mainContext.fetch(fetchRequest)
    }
    
//    func getSubjectByName(name: String) throws -> Subject?
//    {
//        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
//        let namePredicate = NSPredicate(format: "name = %@", name)
//        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Subject.name, ascending: false)]
//        fetchRequest.predicate = namePredicate
//        let results = try mainContext.fetch(fetchRequest)
//        if results.count > 0 {
//            return results[0]
//        }
//        return nil
//    }
    
    func createToDo(name: String, date: Date, subject: Subject, tasks: [String]) throws {
        let toDo = ToDo(context: mainContext)
        
        toDo.name = name
        toDo.finishDate = date
        subject.addToToDos(toDo)
        try save()
        for t in tasks {
            try self.createTasks(notes: t, toDo: toDo)
        }
    }
    
    func deleteToDo(toDo: ToDo) throws {
        mainContext.delete(toDo)
        
        try save()
    }
    
    func createTasks(notes: String, toDo: ToDo) throws {
        let tasks = Task(context: mainContext)
        
        tasks.task = notes
        tasks.done = false
        toDo.addToTasks(tasks)
        try save()
    }
    
    func deleteTasks(tasks: Task) throws {
        mainContext.delete(tasks)
        
        try save()
    }
    
    func getEntityById(id: NSManagedObjectID) throws -> NSManagedObject? {
        return try mainContext.existingObject(with: id)
    }
    
}

enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}
