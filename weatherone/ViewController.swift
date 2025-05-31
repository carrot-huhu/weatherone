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

class ViewController: UIViewController{
   
    

    @IBOutlet weak var backgroundview: UIView!
    
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
    
    let gradientLayer = CAGradientLayer()
    
    let locationmanage = CLLocationManager()
    let weather = Weather()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundview.layer.addSublayer(gradientLayer)
        // Do any additional setup after loading the view.
        print("strart")
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        //初始化加载动画
        
        activityIndicator.backgroundColor = UIColor.black
        //设置加载动画背景颜色
        
        view.addSubview(activityIndicator)
        //添加加载动画
        
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
        print(date)
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if (hour >= 6 && hour < 18) {
            setPinkGradientBackground()
            print(hour)
        }else{
            setBlueGradientBackground()
            print(hour)
        }
        
        locationmanage.requestWhenInUseAuthorization()//请求授权获取当前位置
        activityIndicator.startAnimating() // 开始加载动画
        print("开始加载动画")
        
        locationmanage.delegate = self
        
        locationmanage.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationmanage.requestLocation()
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        setPinkGradientBackground()
//        print("默认加载背景")
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QueryViewControllerSegue"{
             let vc = segue.destination as! QueryViewController
             vc.currentcity = weather.city
             vc.delegate = self
            //将目标控制器的delagate设置成当前控制器
            }
    }
    
    // 设置背景为蓝粉色渐变
    func setPinkGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor                  // 蓝色
        let bottomColor = UIColor(red: 241.0/255.0 , green: 158.0/255.0, blue: 194.0/255.0, alpha: 1.0).cgColor     // 粉色
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }

    // 设定背景为蓝灰渐变
    func setBlueGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor                  // 蓝色
        let bottomColor = UIColor(red: 72.0/255.0 , green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    // 设置背景为灰色渐变
    func setGrayGradientBackground() {
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0 , green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    


    
}

