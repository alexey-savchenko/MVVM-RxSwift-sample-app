//
//  Cache.swift
//  networkTest
//
//  Created by Alexey Savchenko on 20.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import CoreData

class Cache {
  let coreDataStack = CoreDataCacheStack.shared

  func save(_ data: Data, for resource: Cacheable) {
    // Check for item in cache
    let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
    request.predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)

    if let res = try! coreDataStack.managedObjectContext.fetch(request).first as? CachedEntity {
      // Update cached resource
      res.data = data
    } else {
      // Create new cached item
      let cacheItem = CachedEntity(context: coreDataStack.managedObjectContext)
      cacheItem.data = data
      cacheItem.cacheKey = resource.cacheKey
    }
    try! coreDataStack.managedObjectContext.save()
  }

  func loadData<T>(for resource: ArrayResource<T>) -> [T] {
    let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
    let predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)
    request.predicate = predicate
    if let result = (try? coreDataStack.managedObjectContext.fetch(request) as! [CachedEntity])?.first {
      if let data = result.data {
        if let decodedData = try? JSONDecoder().decode([T].self, from: data) {
          return decodedData
        } else {
          return []
        }
      } else {
        return []
      }
    } else {
      return []
    }

  }
  func loadData<T>(for resource: SingleItemResource<T>) -> T? {
    return nil // TODO: Implement
  }
}
