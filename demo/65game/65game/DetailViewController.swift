//
//  DetailViewController.swift
//  65game
//
//  Created by liukelin on 15/2/28.
//  Copyright (c) 2015年 liukelin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //@IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    
    @IBOutlet weak var label_game_name: UILabel!
    @IBOutlet weak var label_game_type: UILabel!
    @IBOutlet weak var label_game_title: UILabel!
    @IBOutlet weak var text_game_detail: UITextView!
        
    var game_name:String?
    var game_id:String?
    var detailItem: AnyObject?
    var game_data: Dictionary<String,AnyObject>?
    
    //填充数据
    func configureView() {
        // Update the user interface for the detail item.
        /*
        if let detail: AnyObject = self.detailItem { //接收为未知类型
            let label = self.detailDescriptionLabel
            var detailData_ = detail as Dictionary<String,AnyObject>
            label.text = detailData_["game_name"] as? String
            //label.text = game_data
        }*/
        
        

        let detail2: AnyObject = self.detailItem!
        var detailData_2 = detail2 as! Dictionary<String,AnyObject>
        var imgs = detailData_2["pic"] as! Dictionary<String,AnyObject>
        let img_url = "http://static.65.com/platform/Uploads/images/"+(imgs["pic1"] as! String)
        self.detailImg.image = UIImage(data: NSData(contentsOfURL: NSURL(string: img_url)!)!)
        
        self.title = detail2["game_name"] as? String //view title
        self.label_game_type.text = detail2["game_type"] as? String
        self.label_game_name.text = detail2["game_name"] as? String
        self.label_game_type.text = detail2["game_type"] as? String
        self.label_game_title.text = detail2["game_descript"] as? String
        
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
            //从接口获取数据
            let curl = curl1()
            let datas = curl.requestUrl( "http://api.65.com/65sdk/m_game.php?action=gamedetail&gid="+self.game_id!)
            self.game_data = datas["data"] as? Dictionary<String,AnyObject>
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                var game_version = self.game_data!["game_version"] as? Dictionary<String,AnyObject>
                var andriod_version = game_version?["android"] as? Dictionary<String,AnyObject>
                var ios_version = game_version?["ios"] as? Dictionary<String,AnyObject>
                
                var game_detail: String?
                let msg = andriod_version!["msg"] as? String
                let msg1 = ios_version!["msg"] as? String
                
                if msg=="" {
                    game_detail = msg1
                }else if msg1=="" {
                    game_detail = msg
                }
                
                self.text_game_detail.text = game_detail

            })
            
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

