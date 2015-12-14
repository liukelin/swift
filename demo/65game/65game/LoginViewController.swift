//
//  LoginViewController.swift
//  65game
//  登录界面
//  Created by liukelin on 15/3/17.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var loading_s: UIActivityIndicatorView!
    @IBOutlet weak var showView: UIView! //注册层
    
    @IBOutlet weak var reg_user: UITextField! //注册 user
    @IBOutlet weak var reg_pwd: UITextField!  //注册 pwd
    
    var data_ : Dictionary<String,AnyObject>?//接口返回结果 为字典
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置父类视图，高度不计入窗口尺寸
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.translucent = false

        // Do any additional setup after loading the view.
       // let addButton = UIBarButtonItem( style: UIBarButtonItemStyle.Plain,target: self.loading_s, action: "logindd")
        //self.navigationItem.rightBarButtonItem = addButton //顶部右侧按钮修改
        
        
       // self.rightButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self.loading_s,action: "")
        //showViewss()
        self.loading_s.hidden=true //隐藏控件
        self.showView.hidden = true
        
        
    }
    
    
    
    
    //显示隐藏
    @IBAction func hide_button(sender: AnyObject) {
        let button = sender as! UIButton
        let button_text = button.titleLabel?.text
        if button_text=="X" {
            self.showView.hidden = true
        }else if button_text=="注册" {
            showRegView()
        }
        
    }
    
    //显示 view
    func showRegView(){
        self.showView.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.showView.frame = CGRectMake(self.showView.frame.origin.x, UIScreen.mainScreen().bounds.size.height/2 - 200/2 - 64, 300, 200);
        });
    }
    
    
    //login
    @IBAction func logindd(sender: AnyObject) {
        
        login_(self.user.text!,pwd: self.pwd.text!)
    }
    
    //reg
    @IBAction func reg_button(sender: AnyObject) {
        
        register_(self.reg_user.text!,pwd: self.reg_pwd.text!)
    }
    
    //代码创建层
    func showViewss(){
        // self.showView.
        /*
        var label2 = UILabel()
        label2.frame = CGRectMake(10, 10, 10, 18);
        label2.text = "按钮"
        
        let alert = UIAlertView()
        alert.title = "提示"
        alert.addSubview(label2)
        alert.addButtonWithTitle("Ok")
        alert.show()
        */
        
        //创建层
        let view = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 300/2, UIScreen.mainScreen().bounds.size.height, 300, 200));
        view.backgroundColor = UIColor.redColor()
        self.view.addSubview(view)
        
        //层显示动画
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            view.frame = CGRectMake(view.frame.origin.x, UIScreen.mainScreen().bounds.size.height/2 - 200/2 - 64, 300, 200);
        });
        
        //创建控件
        for i in 0...1
        {
            let label = UILabel();
            label.frame = CGRectMake(10, (CGFloat)(5 * (i + 1)) + (CGFloat)(18 * i), 300 - 20, 18);
            if i == 0
            {
                label.text = "账号：";
            }else
            {
                label.text = "密码：";
            }
            label.backgroundColor = UIColor.clearColor();
            label.textColor = UIColor.blackColor();
            label.font = UIFont.systemFontOfSize(14);
            view.addSubview(label) //把 label 加入 层
        }
    }

    
    //登录
    func login_(user: String, pwd: String){
        
        var ret = 0
        var echomsg = ""
        if user.characters.isEmpty {
            echomsg = "用户名为空！"
            ret = 1
        }
        if pwd.characters.isEmpty {
            echomsg = "密码为空！"
            ret = 1
        }
        
        let url = "http://sdk.65.com/api.php?action=login&login_account=\(user)&password=\(pwd)&deviceno=0dc1479beac32895990da61057f0c991&cid=1&gid=6&app_key=ddb4a9ae3cc060ebdfe64c4cc1cb7524"
        
        if ret == 0 {
            self.loading_s.startAnimating() //启动 loading
            
            //异步执行 体
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                
                let curl = curl1()
                let data = curl.requestUrl( url )
                
                //异步执行 结果
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loading_s.stopAnimating()
                    
                    //登录结果判断
                    self.data_ = data as? Dictionary<String,AnyObject>
                    let code = (self.data_)!["code"] as! Int
                    var msg = ""
                    
                    if code == 0 {
                        self.performSegueWithIdentifier("pushShowList", sender: self)//启用跳转
                    }else {
                        msg = (self.data_)!["msg"] as! String
                        
                        let alert = UIAlertView()
                        alert.title = "提示"
                        alert.message = msg
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                        
                    }
                    
                })
                
            })
        }else {
            let alert = UIAlertView()
            alert.title = "提示"
            alert.message = echomsg
            alert.addButtonWithTitle("Ok")
            alert.show()
        }

    }
    
    //注册
    func register_(user:String, pwd:String){
        var ret = 0
        var echomsg = ""
        if self.reg_user.text!.characters.isEmpty {
            echomsg = "用户名为空！"
            ret = 1
        }
        if self.reg_pwd.text!.characters.isEmpty {
            echomsg = "密码为空！"
            ret = 1
        }
        
        let url = "http://sdk.65.com/api.php?action=register&username=\(self.reg_user.text)&password=\(self.reg_pwd.text)&deviceno=0dc1479beac32895990da61057f0c991&cid=1&gid=6&app_key=ddb4a9ae3cc060ebdfe64c4cc1cb7524"
        
        if ret == 0 {
            self.loading_s.startAnimating() //启动 loading
            
            //异步执行 体
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                
                let curl = curl1()
                let data = curl.requestUrl( url )
                
                //异步执行 结果
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loading_s.stopAnimating()
                    
                    //登录结果判断
                    self.data_ = data as? Dictionary<String,AnyObject>
                    let code = (self.data_)!["code"] as! Int
                    var msg = ""
                    
                    if code == 0 {
                        //self.performSegueWithIdentifier("pushShowList", sender: self)//启用跳转
                        msg = "注册成功"
                    }else {
                        msg = (self.data_)!["msg"] as! String
                    }
                    let alert = UIAlertView()
                    alert.title = "提示"
                    alert.message = msg
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                })
                
            })
        }else {
            let alert = UIAlertView()
            alert.title = "提示"
            alert.message = echomsg
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
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
