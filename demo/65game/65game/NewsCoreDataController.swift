//
//  NewsCoreDataController.swift
//  65game
//
//  Created by liukelin on 15/4/2.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//
import UIKit
import CoreData

class NewsCoreDataController:NSObject {
    
    let store: CoreDataStore!
    let cdh: CoreDataHelper!
    
    override init() {
        super.init()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.store = appDelegate.cdstore
        self.cdh = appDelegate.cdh
    }
    
    func fetchNewestNews()->NSFetchedResultsController {
        var error:NSError? = nil
        var fReq:NSFetchRequest = NSFetchRequest(entityName: "News")
        var sorter:NSSortDescriptor = NSSortDescriptor(key: "newsDate", ascending: false)
        fReq.sortDescriptors = [sorter]
        fReq.fetchBatchSize = 20
        fReq.fetchLimit = 20
        return NSFetchedResultsController(fetchRequest: fReq, managedObjectContext: self.cdh.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //按条件检查entity是否有符合条件数据
    func fetchOneWithConditionForCheckIfExist(entityName:String,condition:NSPredicate)->[AnyObject]! {
        var fetchReq = NSFetchRequest(entityName: entityName)
        fetchReq.predicate = condition
        fetchReq.fetchLimit = 1
        var error:NSError? = nil
        return self.cdh.managedObjectContext.executeFetchRequest(fetchReq, error: &error)
    }
    
    //检查entity里是否有数据
    func fetchOneForCheckIfExist(entityName:String)->[AnyObject]! {
        var fetchReq = NSFetchRequest(entityName: entityName)
        fetchReq.fetchLimit = 1
        var error:NSError? = nil
        return self.cdh.managedObjectContext.executeFetchRequest(fetchReq, error: &error)
    }
    
    func insertForEntityWithName(entityName:String)->AnyObject! {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: self.cdh.managedObjectContext)
    }
    
    //删除一个entity里的所有数据
    func deleteOneEntityAllData(entityName:String) {
        var error:NSError? = nil
        var fReq:NSFetchRequest = NSFetchRequest(entityName: entityName)
        var result = self.cdh.backgroundContext.executeFetchRequest(fReq, error: &error)
        //println(result.count)
        for resultItem in result! {
            self.cdh.backgroundContext.deleteObject(resultItem as NSManagedObject)
        }
        self.save()
    }
    
    func save() {
        self.cdh.saveContext(self.cdh.managedObjectContext)
    }
}
