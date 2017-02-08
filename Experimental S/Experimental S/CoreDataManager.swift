//
//  CoreDataManager.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 09/01/2017.
//  Copyright © 2017 Fábio Carvalho. All rights reserved.
//

import CoreData

@available(iOS 10.0, *)

class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    } 
}
