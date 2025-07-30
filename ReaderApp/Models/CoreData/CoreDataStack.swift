//
//  CoreDataStack.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ReaderApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(" Core Data load error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(" Save error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

