//
//  ViewController1Detail.swift
//  test1
//
//  Created by liukelin on 15/3/7.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import UIKit

class ViewController1Detail: UIViewController {

    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsDetail: UITextView!
    @IBOutlet weak var goodsImage: UIImageView!
    var goods_id:String?
    var goods_data:AnyObject? //未知类型
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showDataDetailView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //填充数据
    func showDataDetailView(){
        
        let data: AnyObject = self.goods_data!
        var data_ = data as! Dictionary<String,AnyObject>
        
        //println(data)
        
        var img_s = data_["goods_img"] as! Dictionary<String,AnyObject>
        let img_url = img_s["pic3"] as? String
        self.goodsImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: img_url!)!)!)
        self.title = data_["goods_name"] as? String
        
        let goods_id = data_["goods_id"] as? String
        //获取礼包详细
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
            //从接口获取数据
            let curl = curl1()
            let datas = curl.requestUrl( "http://api.shop.65.com/?action=goods_detail&goods_id="+goods_id!)
            var game_data = datas["data"] as? Dictionary<String,AnyObject>
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in

                self.goodsDetail.text = game_data!["goods_description"] as? String
                
                print( game_data!["goods_description"] )

            })
        })
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
