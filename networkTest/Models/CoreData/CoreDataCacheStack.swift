//
//  CoreDataStack.swift
//  networkTest
//
//  Created by Alexey Savchenko on 18.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import CoreData
import Foundation

class CoreDataCacheStack {
  lazy var managedObjectContext: NSManagedObjectContext = {
    return persistentContainer.viewContext
  }()
  let persistentContainer: NSPersistentContainer
  init(_ modelName: String) {
    persistentContainer = NSPersistentContainer(name: modelName)
    persistentContainer.loadPersistentStores { (_, error) in
      guard error == nil else {
        fatalError(error!.localizedDescription)
      }
    }
  }
}
