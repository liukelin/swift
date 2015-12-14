// 本地数据存储
//  storageData.swift
//  65game

//  Created by liukelin on 15/4/2.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import Foundation

class storageData{
    
    //NSHomeDirectory存储
    func setShahe(i : String, key : String = "", val : String = "")->String{
        //存储文件路径
        //NSHomeDirectory()
        
        //可以存储为任何对象
        let strarr:[String] = ["理想","swift"];
        //存入一个字典 
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(strarr), forKey: "ss");
        
        //取出 字典
        let data = NSUserDefaults.standardUserDefaults().objectForKey("ss") as! NSData;
        let object: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data);
        
        
        
        var getVal = ""
        
        if i=="set" {
            //set
            NSUserDefaults.standardUserDefaults().setObject(val, forKey: key);
        }else if i=="get" {
            
            //get
            getVal = (NSUserDefaults.standardUserDefaults().objectForKey(key)) as! String
        }
        
        return getVal
    }


}
