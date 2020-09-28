//
//  DataManager.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/25/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "WheatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
    }()
    
    func viewContext() -> NSManagedObjectContext {
        
        return persistentContainer.viewContext
        
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        
        return persistentContainer.newBackgroundContext()
        
    }

    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
}
