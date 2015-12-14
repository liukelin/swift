//
//  CoreDataStore.swift
//  65game
//
//  Created by liukelin on 15/4/2.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//
import Foundation
import CoreData
class CoreDataStore: NSObject{
    let storeName = "News"
    let storeFilename = "News.sqlite"
    var managedObjectModel: NSManagedObjectModel {
    if _managedObjectModel == nil {
        let modelURL = NSBundle.mainBundle().URLForResource(storeName, withExtension: "momd")
        _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
        }
        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
    if _persistentStoreCoordinator == nil {
        let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent(storeFilename)
        var error: NSError? = nil
        _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
            abort()
        }
        }
        return _persistentStoreCoordinator!
    }
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil
    // #pragma mark - Documents directory
    var applicationDocumentsDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as! NSURL
    }
}