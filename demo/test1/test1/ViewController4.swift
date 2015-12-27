//
//  ViewController4.swift
//  页面布局

//  Created by liukelin on 15/2/17.
//  Copyright (c) 2015年 liukelin. All rights reserved.
/*

1 . 元素 自身的长宽 和 X Y 间隙设置

2 . 元素基于父类视图的位置设置
    Top Space to Superview（与父视图的顶端间隔）
    Leading Space to Superview（与父视图的首部间隔）
    Trailing Space to Superview（与父视图的尾部间隔）
    Bottom Space to Superview（与父视图的底端间隔）

3 .元素间相对位置设置(选中多个元素)
    相同高度 Editor/Pin/Heights Equally
    相同宽度 Editor/Pin/Widths Equally
    水平间隔 Editor/Pin/Horizontal Spacing
    垂直间隔 Editor/Pin/Vertical Spacing
*/

import UIKit

class ViewController4: UIViewController {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
