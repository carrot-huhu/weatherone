//
//  ViewController.swift
//  weatherone
//
//  Created by huqy on 2025/5/26.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController {

    
    @IBOutlet weak var datelabel: UILabel!
    
    
    @IBOutlet weak var weeklabel: UILabel!
    
    @IBOutlet weak var iconimagefield: UIImageView!
    

    @IBOutlet weak var icontextlabel: UILabel!
    
    @IBOutlet weak var templabel: UILabel!
    
    
    @IBOutlet weak var humiditylabel: UILabel!
    
    @IBOutlet weak var vislabel: UILabel!
    
    @IBOutlet weak var windDirlabel: UILabel!
    
    
    @IBOutlet weak var windScalelabel: UILabel!
    
    @IBOutlet weak var citylabel: UILabel!
    
    var activityIndicator: NVActivityIndicatorView!
    
    let locationmanage = CLLocationManager()
    let weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("strart")
        
        // 显示是周几
       let date = Date()
       let dateFormatter1 = DateFormatter()
       let dateFormatter2 = DateFormatter()
       let dateFormatter3 = DateFormatter()
       dateFormatter1.dateFormat = "M"
       dateFormatter2.dateFormat = "d"
       dateFormatter3.dateFormat = "EEEE"
       self.datelabel.text = "\(dateFormatter1.string(from: date))月\(dateFormatter2.string(from: date))日"
       self.weeklabel.text = dateFormatter3.string(from: date)
    
        print(dateFormatter1.string(from: date))
        print(dateFormatter2.string(from: date))
        print(dateFormatter3.string(from: date))
        
        locationmanage.requestWhenInUseAuthorization()//请求授权获取当前位置
        locationmanage.delegate = self
        
        locationmanage.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationmanage.requestLocation()
        
        
    }


}

