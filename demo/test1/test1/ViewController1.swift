//
//  ViewController1.swift
//  TableView 控件

//  Created by liukelin on 15/2/10.
//  Copyright (c) 2015年 liukelin. All rights reserved.
// 新建视图代码文件 newfile - >cocoa tocuh class -> 选择UIViewController 把视图class设置到这个文件名
//

import UIKit

class ViewController1: UIViewController,UITableViewDataSource,UITableViewDelegate {


    var refreshControl :UIRefreshControl?
    //加载运行
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        //table View Controller 支持下拉刷新
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: "showDataToTableView", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        */
        showDataToTableView()//填充数据
    }

    /*===========view2===========*/
    /*
    tableView 必要事件 dataSource、delegate
    继承 UITableViewDataSource,UITableViewDelegate
    必要函数
    
    */
    @IBOutlet weak var testUitable: UITableView! //加入UITableView
    var array_list : Array<Dictionary<String,AnyObject>>? //定义数据源变量 已知数据源为 数组字典：

    //往 tableView 填充数据
    func showDataToTableView(){
        
        //异步执行 处理
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
            //项目下 可调用文件
            let curl = curl1()
            let data = curl.requestUrl( "http://api.shop.65.com/?action=goods_list&status=3")
            self.array_list = data["list"] as? Array<Dictionary<String,AnyObject>> // 选取json数据源的 list 进行循环 已知数据类型为 数组字典
           
            //异步执行 结果
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                //定义为 Cell 为 tableView 的 cell 设置 Identifier=Cell
                if (self.testUitable != nil)
                {
                    self.testUitable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                    self.testUitable.reloadData() //刷新
                }
            })
        })
        
        
        
        
    }

    
    //点击按钮执行
    @IBAction func onclick_(sender: AnyObject) {
        showDataToTableView()
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "刷新成功"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    // MARK: - Segues  窗口跳转触发  tableView 中会被 tableView 的点击事件劫持，所以跳转使用 tableView 自带 点击事件didSelectRowAtIndexPath
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goodsShowDetailSegue" {//判断跳转的指向
            
            if let indexPath = self.testUitable.indexPathForSelectedRow {//获取选中的行标

                let goods_data: AnyObject? = self.array_list![indexPath.row] as AnyObject?
                let goods_id:String = self.array_list![indexPath.row]["goods_id"] as! String
                
                //传递值1 ViewController1Detail:目标页面   detailItem:目标变量
                
                print("segue.destinationViewController = \(segue.destinationViewController)");
                
                let theSegue = segue.destinationViewController as? ViewController1Detail
                if (theSegue != nil)
                {
                    theSegue!.goods_id = goods_id //goods_id ：目标页面的变量
                    theSegue!.goods_data = goods_data
                }
                
            }
        }
    }
    
    //tableView 必须函数1 : 数据数量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.array_list != nil {
            return self.array_list!.count
        }else{
            return 0
        }
    }
    
    //tableView 必须函数2 : 数据内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if cell != nil
        {
            //UITableViewCellStyle 的值为控制 tableView 样式
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        //行下标
//        var row_ = indexPath.row as Int

        //数据列
        
        //var image = self.array_list![indexPath.row] as Dictionary
        var images = self.array_list![indexPath.row]["goods_img"] as! Dictionary<String,String>? //转化为字典
        
        //cell!.imageView?.image = UIImage(named: "");//读取本地图片
        cell!.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: images!["pic1"] as String!)!)!)//读取网络图片方法
        
        cell!.textLabel?.text   = self.array_list![indexPath.row]["goods_name"] as? String
        let goods_price         = self.array_list![indexPath.row]["goods_price"] as? String
        let goods_name          = self.array_list![indexPath.row]["goods_name"] as? String
        cell!.detailTextLabel?.text = goods_price!+goods_name!
        
        //println(goods_name)
        return cell!
    }
    
    //tableView 选调配置函数：行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    //删除一行 滑动删除功能
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        let index=indexPath.row as Int
        self.array_list!.removeAtIndex(index)
        self.testUitable?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        NSLog("删除\(indexPath.row)")
    }
    
    //tableView 点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var msg = ""
        if (self.array_list![indexPath.row]["goods_id"] != nil) {
            msg = self.array_list![indexPath.row]["goods_name"] as! String
            self.performSegueWithIdentifier("goodsShowDetailSegue", sender: self)//启用跳转
        }else{
            msg = "没有详细"
        }
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = msg
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
