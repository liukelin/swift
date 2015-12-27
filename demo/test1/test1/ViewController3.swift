//
//  ViewController3.swift
//  test1
//  web View 控件 和 布局
//  Created by liukelin on 15/2/12.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//
/*
1 . webview 自身的 X Y 间隙设置 以及：
    Leading Space to Superview（与父视图的首部间隔）
    Trailing Space to Superview（与父视图的尾部间隔）
    Bottom Space to Superview（与父视图的底端间隔）
2 .头部输入框等元素和 webview 的相对位置设置
 布局  头部一行内的所有元素选中设置 相同高度 Pin/Heights Equally
 选择其中一个头部元素和 webView 设置垂直间隔 /Pin/Vertical Spacing
*/

import UIKit

class ViewController3: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webViews: UIWebView!
    @IBOutlet weak var url_text: UITextField!
    
    var on_url = "http://baidu.com"
    var black_url = "http://baidu.com"//上一页
    var go_url = "http://baidu.com"//下一页
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        open_url1()
        // Do any additional setup after loading the view.
    }
    
    //操作
    @IBAction func button_go_url(sender: AnyObject) {
        let button = sender as! UIButton
        var urlText = url_text.text
        
        if button.titleLabel?.text=="GO" {
            
        } else if button.titleLabel?.text=="＜" {//上一页
            
            urlText = black_url
            go_url = on_url
        } else if button.titleLabel?.text=="＞" {//下一页
            urlText = go_url
        }
        open_url1(urlText!)
        
        black_url = on_url
        on_url = urlText!
    }
    
    
    
    //全窗口打开链接
    func open_url(){
        let webView = UIWebView(frame:self.view.bounds)
        let url = NSURL(string: "http://baidu.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        self.view.addSubview(webView)
    }
    
    //在 webVew 打开
    func open_url1(url_:String = "http://baidu.com"){
        var url_s:String
        if url_.hasPrefix("http://") {
            url_s = url_
        }else{
            url_s = "http://"+url_
        }
        url_text.text = url_s
        //println(url_s)

        let url:NSURL = NSURL(string:url_s)!
        let request:NSURLRequest = NSURLRequest(URL:url)
        self.webViews.loadRequest(request)
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
