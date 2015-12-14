//
//  CoreDataHelper.swift
//  65game
//
//  Created by liukelin on 15/4/2.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import CoreData
import UIKit
class CoreDataHelper: NSObject{
    let store: CoreDataStore!
    override init(){
        super.init()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.store = appDelegate.cdstore
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextDidSaveContext:", name: NSManagedObjectContextDidSaveNotification, object: nil)
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // #pragma mark - Core Data stack
    // main thread context
    var managedObjectContext: NSManagedObjectContext {
        if _managedObjectContext == nil {
            let coordinator = self.store.persistentStoreCoordinator
            if coordinator != "" {
                
                _managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil
    var backgroundContext: NSManagedObjectContext {
        if _backgroundContext == nil {
            let coordinator = self.store.persistentStoreCoordinator
            if coordinator != ""  {
                _backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
                _backgroundContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _backgroundContext!
    }
    var _backgroundContext: NSManagedObjectContext? = nil
    // save NSManagedObjectContext
    func saveContext (context: NSManagedObjectContext) {
        var error: NSError? = nil
        if context != ""  {
            if context.hasChanges && !context.save(&error) {
                NSLog("Unresolved error (error)")
                abort()
            }
        }
    }
    func saveContext () {
        self.saveContext( self.backgroundContext )
    }
    // call back function by saveContext, support multi-thread
    func contextDidSaveContext(notification: NSNotification) {
        let sender = notification.object as! NSManagedObjectContext
        if sender === self.managedObjectContext {
            NSLog("======= Saved main Context in this thread")
            self.backgroundContext.performBlock {
                self.backgroundContext.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else if sender === self.backgroundContext {
            NSLog("======= Saved background Context in this thread")
            self.managedObjectContext.performBlock {
                self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else {
            NSLog("======= Saved Context in other thread")
            self.backgroundContext.performBlock {                self.backgroundContext.mergeChangesFromContextDidSaveNotification(notification)
            }
            self.managedObjectContext.performBlock {
                self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
            }
        }
    }
}