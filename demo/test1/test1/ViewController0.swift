//
//  ViewController.swift
//  test1 计算器
//
//  Created by liukelin on 15/1/29.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import UIKit

class ViewController0: UIViewController {
    
    // ! 必须值  ? 可选值
    @IBOutlet weak var text1: UITextField!
    
    var valto1 = "";//值1
    var valto2 = "";//值2
    var valto3 = "" //结果
    var xt = "" //运算符
    
    //storage： weak 、strong  的作用？
    
    /*===开始计算器==*/
    //运算
    func ectss(a:String, b:String, c:String)->Int{
        let val1 = Int(a)!
        let val2 = Int(b)!
        
        var val_ = 0
        if c=="+" {
            val_ = val1 + val2
        }else if c=="-" {
            val_ = val1 - val2
        }else if c=="×" {
            val_ = val1 * val2
        }else if c=="÷" {
            val_ = val1 / val2
        }else {
            val_ = val1
        }
        return val_
    }
    
    //= 号 操作
    func chanl(){
        if(valto1.isEmpty || valto2.isEmpty || xt.isEmpty){
            
        }else{
            let valr = ectss(valto1,b: valto2,c: xt)
            
            valto1 = String(valr)
            valto2 = ""
            xt = ""
            valto3 = String(valr)
            text1.text = valto3
        }
    }
    
    //判断文本框值 (数字调用)
    func check_text1(a:String){
        if valto1.isEmpty {
            valto1 = a
        }else{
            if xt.isEmpty {
                valto1 = valto1+a
            }else{
                if valto2.isEmpty {
                    valto2 = a
                }else{
                    valto2 = valto2+a
                }
            }
        }
    }
    
    //判断文本框值 （运算符调用）
    func check_yunsuan(a:String){
        
        if valto1.isEmpty {
            
        }else{
            if valto2.isEmpty {
                xt = a
            }
        }
    }
    
    //运算符
    @IBAction func tex_yunsuan(sender: AnyObject) {
        let button = sender as! UIButton
        let xt_ = button.titleLabel?.text;//获取按钮的值
        
        if(valto1.isEmpty || valto2.isEmpty || xt.isEmpty){
            
        }else{
            chanl() // 执行=
        }
        check_yunsuan(String(xt_!))//因为xt_赋值时候为 “？” 所以此处必须规定为有值"!"
        valto3 =  valto1+xt+valto2
        text1.text = valto3
    }
    
    //数字按钮（多个按钮指定一个方法）
    @IBAction func buttonnum(sender: AnyObject) {
        //创建控件选择的是 AnyObject类型，所以需要转为控件自身类型
        let button = sender as! UIButton
        let num = button.titleLabel?.text;//获取按钮的值
        
        check_text1(String(num!))//因为xt_赋值时候为 “？” 所以此处必须规定为有值"!"
        valto3 =  valto1+xt+valto2
        text1.text = valto3
    }
    
    //=
    @IBAction func button1(sender: AnyObject) {
        chanl()
    }
    
    //c
    @IBAction func numc(sender: AnyObject) {
        valto1 = ""
        valto2 = ""
        xt = ""
        valto3 = ""
        text1.text = "0"
    }
    /*---结束计算器---*/
    
    
    
    //返回
    @IBAction func go_block(sender: AnyObject) {
        //go_block1 为 Segue 的 Identifier
        self.performSegueWithIdentifier("go_block1", sender: self)
    }
    
    
    /*
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
    //加载运行
    }
    
    override func viewWillDisappear(animated: Bool) {
    
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

