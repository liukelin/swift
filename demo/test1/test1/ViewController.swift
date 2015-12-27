//
//  ViewController.swift
//  目录
//
//  Created by liukelin on 15/1/29.
//  Copyright (c) 2015年 liukelin. All rights reserved.
// 穿件 navigation Controller 父类视图，然后设置成 root View Controller 跳转 成为父视图

import UIKit

class ViewController: UIViewController {
    
    
    //加载运行
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //设置父类视图，高度不计入窗口尺寸
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.translucent = false
    }
    
    
    // MARK: - Segues  窗口跳转 触发
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var msgs = ""
        if segue.identifier == "push_viewController0" { //segue.identifier为跳转 Segue identifier
            msgs = "计算器"
        } else if segue.identifier == "push_viewController1" {
            msgs = "viewController1"
        }else {
            msgs = " segue.identifier :\(segue.identifier)"
        }
        
        /*=传递参数=
        //DetailViewController：目标页面名称
        var theSegue = segue.destinationViewController as DetailViewController
        theSegue.game_name = "Pass" //game_data ：目标页面的变量
        */
        
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "你选择的是:\(msgs)"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("No")
        alert.show()
    }
    
    
    //代码跳转
    @IBAction func push_jump(sender: AnyObject) {
        
        let button = sender as! UIButton //已知 此控件为 button 转为 此类型
        let text = button.titleLabel?.text;//获取按钮的文本
        var push_name = ""
        
        //判断需要跳转 窗口
        if text == "TableView2" {
            push_name = "push_viewController2"
        }
        
        //1.使用 设置跳转的 Segue 名称 跳转
        self.performSegueWithIdentifier(push_name, sender: self)
        
        
        //2.使用 目标窗口名称 跳转
        //self.presentViewController(anotherView, animated: true, completion: nil)
        
        /*
        //push方式
        self.navigationController.pushViewController(vc, animated:true)
        //present方式
        self.presentViewController(vc, animated: true, completion: nil)
        */
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

