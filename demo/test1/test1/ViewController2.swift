//
//  ViewController2.swift
//  test1
//  Table View 控件2

//  Created by liukelin on 15/2/10.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import UIKit

class ViewController2: UIViewController,UITableViewDataSource ,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var leftBtn:UIButton?
    var rightButtonItem:UIBarButtonItem?
    //@IBOutlet weak var rightButtonItem: UIButton!
    
    var items :Array<String> = ["武汉","上海","北京","深圳","广州"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pash 跳转方式才支持 需要设置成 pash 跳转方式并且设置 navigation Controller 才允许设置头部按钮
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试", style: UIBarButtonItemStyle.Plain, target: self,action: "rightBarButtonItemClicked")
        
        initView()
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
        self.leftBtn!.userInteractionEnabled = true

        
        // Do any additional setup after loading the view.
    }

    func initView(){
        // 初始化tableView的数据
//        self.tableView=UITableView(frame:self.view.frame,style:UITableViewStyle.Plain)
        // 设置tableView的数据源
//      self.tableView!.dataSource=self
        // 设置tableView的委托
//      self.tableView!.delegate = self

        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.view.addSubview(self.tableView!)
        self.tableView.reloadData() //刷新

    }
    
    //加左边按钮 需要设置成 pash 跳转方式并且设置 navigation Controller 才允许设置头部按钮
    func setupLeftBarButtonItem(){
        self.leftBtn = UIButton(type: UIButtonType.Custom) as? UIButton
        self.leftBtn!.frame = CGRectMake(60,0,50,40)
        self.leftBtn?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        self.leftBtn!.tag = 100
        self.leftBtn!.userInteractionEnabled = false
        self.leftBtn?.addTarget(self, action: "leftBarButtonItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
        let barButtonItem = UIBarButtonItem(customView: self.leftBtn!)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    //左边按钮事件
    func leftBarButtonItemClicked(){
        //println("leftBarButton")
        if (self.leftBtn!.tag == 100){
            self.tableView?.setEditing(true, animated: true) //点击编辑按钮
            self.leftBtn!.tag = 200
            self.leftBtn?.setTitle("Done", forState: UIControlState.Normal)
            //将增加按钮设置不能用
            self.rightButtonItem!.enabled=false
        }else{
            //恢复增加按钮
            self.rightButtonItem!.enabled=true
            self.tableView?.setEditing(false, animated: true)
            self.leftBtn!.tag = 100
            self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    //加右边按钮
    func setupRightBarButtonItem(){
        self.rightButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self,action: "rightBarButtonItemClicked")
        self.navigationItem.rightBarButtonItem = self.rightButtonItem
        
    }
    
    //增加一行事件
    func rightBarButtonItemClicked(){
        let row = self.items.count
        let indexPath = NSIndexPath(forRow:row,inSection:0)
        self.items.append("杭州")
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left) //withRowAnimation：载入动画参数
    }
    
    
    //总行数 tableView必要函数1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
    
    //加载数据 tableView必要函数2
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        let row=indexPath.row as Int
        cell.textLabel?.text=self.items[row]
//      cell.imageView?.image = UIImage(named:"green.png")
        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://static.65.com/platform/new/images/w_t9.jpg")!)!)!
        return cell
    }
    
    //删除一行 滑动删除功能
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "你选择的是\(self.items[indexPath.row]),确认删除？"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("No")
        alert.show()
        
        let index=indexPath.row as Int
        self.items.removeAtIndex(index)
        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        NSLog("删除\(indexPath.row)")
        
    }
    
    //选择一行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){

        print("你选择的是\(self.items[indexPath.row])")
        
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "你选择的是\(self.items[indexPath.row])"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    // 支持单元格编辑功能
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
