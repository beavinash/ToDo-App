//
//  AddCoreData.swift
//  ToDo App
//
//  Created by Avinash Reddy on 4/6/19.
//  Copyright © 2019 Avinash Reddy. All rights reserved.
//

import Foundation
import CoreData

class AddCoreData {
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        return container
    }
    
    // helps and take responsibility to maange (save, delete) a collection of objects
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
