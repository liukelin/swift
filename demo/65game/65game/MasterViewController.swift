//
//  MasterViewController.swift
//  65game
//  数据列表页
//  Created by liukelin on 15/2/28.
//  Copyright (c) 2015年 liukelin. All rights reserved.
/*
    1. Table View Contorller
    2. Table View Cell 行属性设置  Style:Basic 以及 命名
    3. cell 设置为 show 跳转方式
*/

import UIKit

class MasterViewController: UITableViewController {

    var objects = NSMutableArray()
    var array_list : Array<Dictionary<String,AnyObject>>? //定义数据源变量 已知数据源为 数组字典：
    @IBOutlet weak var buttonView: UIButton!

    override func awakeFromNib() {//UIVIEW中用
        super.awakeFromNib() //
    }

    override func viewDidLoad() {//UIVIEWCONTROLLER里面用
        super.viewDidLoad()
        
        //设置父类视图，高度不计入窗口尺寸
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.translucent = false
        
        /*
        //使本页面加载 Menu.swift 文件内容
        var window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let menu = Menu()//窗口
        window.rootViewController = menu
        window.makeKeyAndVisible()
        */
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem() //顶部左侧按钮改为编辑

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton //顶部右侧按钮修改
        
        self.title = "65Game"
        
        showDataToTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //填充数据
    func showDataToTableView(){
        
        //loading...
        //loadView_view()
        
        //异步执行 体
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
            let curl = curl1()
            let data = curl.requestUrl( "http://api.65.com/65sdk/m_game.php?action=gamelist&limit=50")
            self.array_list = data["list"] as? Array<Dictionary<String,AnyObject>> // 选取json数据源的 list 进行循环 已知数据类型为 数组字典
        
            //异步执行 结果
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                //定义为 Cell 为 tableView 的 cell 设置 Identifier=Cell
                self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                self.tableView.reloadData() //刷新
                
            })
                
        })
        
    }
    
    //加载状态
    func loadView_view() {
        //UIActivityIndicatorView
        let view1 = UIActivityIndicatorView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 300/2, UIScreen.mainScreen().bounds.size.height, 300, 200));
        self.view.addSubview(view1);
        
        view1.frame = CGRectMake(view.frame.origin.x, UIScreen.mainScreen().bounds.size.height/2 - 200/2 - 64, 300, 200);

    }

    //add 一行数据
    func insertNewObject(sender: AnyObject) {
        /*
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        */
        let row = self.self.array_list!.count
        let indexPath = NSIndexPath(forRow:row,inSection:0)
        self.array_list!.append(["game_name":"测试游戏","pic":["pic1":"54cae28f57fda.png"]]) //数据结构与 行相同
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)//withRowAnimation:载入动画参数
    }

    // MARK: - Segues  窗口跳转触发  tableView 中会被 tableView 的点击事件劫持，所以跳转使用 tableView 自带 点击事件didSelectRowAtIndexPath
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {//判断跳转的指向
            
            if let indexPath = self.tableView.indexPathForSelectedRow {//获取选中的行标
                //let object = objects[indexPath.row] as NSDate
                
                //let object = self.array_list![indexPath.row] as Dictionary<String,AnyObject>
                let object: AnyObject? = self.array_list![indexPath.row] as AnyObject?
               
                //传递值 DetailViewController:目标页面   detailItem:目标变量
                (segue.destinationViewController as! DetailViewController).detailItem = object
                
                
                //传递值2 DetailViewController：目标页面名称
                let theSegue = segue.destinationViewController as! DetailViewController
                // 目标页面的变量
                theSegue.game_name = self.array_list![indexPath.row]["game_name"] as? String
                theSegue.game_id = self.array_list![indexPath.row]["game_id"] as? String
            }
        }
        
    }
    

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // 数量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.array_list!.count
        if self.array_list != nil {
            return self.array_list!.count
        }else{
            return 0
        }
    }

    //数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        //let object = objects[indexPath.row] as NSDate
        //cell.textLabel!.text = object.description
        
        //行下标
        _=indexPath.row as Int
        
        //var image = self.array_list![indexPath.row] as Dictionary
        var images = self.array_list![indexPath.row]["pic"] as! Dictionary<String,String>? //转化为字典
        let img_url = "http://static.65.com/platform/Uploads/images/"+images!["pic1"]!
        
        //cell!.imageView?.image = UIImage(named: "");//读取本地图片
        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: img_url as String!)!)!)//读取网络图片方法
        
        cell.textLabel?.text   = self.array_list![indexPath.row]["game_name"] as? String
        
        return cell
    }
    
    //tableView 点击事件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.array_list![indexPath.row]["game_id"] != nil) {
            self.performSegueWithIdentifier("showDetail", sender: self)//启用跳转
        }else{
            let alert = UIAlertView()
            alert.title = "提示"
            alert.message = "没有详细"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
    }

    //启用编辑
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    //删除功能
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //objects.removeObjectAtIndex(indexPath.row)
            let index=indexPath.row as Int
            self.array_list!.removeAtIndex(index)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

