//
//  curl1.swift
//  test1
//
//  Created by liukelin on 15/2/7.
//  Copyright (c) 2015年 liukelin. All rights reserved.
// http 请求 函数

import Foundation
//import SwiftHTTP //SwiftHTTP库

class curl1{
    
    var res:NSDictionary?; //返回数据类型
    
    init () {
    }
    
    //NSDictionary 转换为 json
    func toJSONString(dict:NSDictionary!)->NSString{
        let data = try? NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
        return strJson!
    }
    
    
    
    //1. 使用NSURLConnection实现了一个简单的异步GET操作
    func requestUrl(urlString: String)-> NSDictionary{
        //var data_:String
        
        let url: NSURL = NSURL(string: urlString)!//写入 url
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        var response: NSURLResponse?
        var error: NSErrorPointer = nil
        let dataVal = (try? NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)) as NSData?
        var err: NSError;
        //println(response);
        
        if let httpResponse = response as? NSHTTPURLResponse {
            res = (try? NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary!
            //println("Synchronous\(jsonResult)")
        }
        return self.res!;
        
        /*
        //调试状态
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error? != nil) {
                //Handle Error here
            }else{
                //Handle data in NSData type
            }
        })
        */
    }
    
    
    
    /*
    //使用SwiftHTTP库。
    func swiftHttp(urlString: String){
        var request = HTTPTask()
        request.GET(urlString, parameters: nil, success: {(response: AnyObject?) -> Void in
            
            },failure: {(error: NSError) -> Void in
                
        })
    }*/
    
}