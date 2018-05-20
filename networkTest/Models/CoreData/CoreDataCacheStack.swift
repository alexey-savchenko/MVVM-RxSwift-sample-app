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
  let modelName: String
  init(_ modelName: String) {
    self.modelName = modelName
    persistentContainer = NSPersistentContainer(name: modelName)
    persistentContainer.loadPersistentStores { (_, error) in
      guard error == nil else {
        fatalError(error!.localizedDescription)
      }
    }
  }

  func flush() {
    let request: NSFetchRequest<CachedEntity> = CachedEntity.fetchRequest()
    let res = try! managedObjectContext.fetch(request)
    guard !res.isEmpty else {
      return
    }
    for i in 0..<res.count {
      managedObjectContext.delete(res[i])
    }
    try! managedObjectContext.save()
  }
}
