//
//  Viewcontroller-locationdelegate.swift
//  weatherone
//
//  Created by huqy on 2025/5/30.
//
import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

extension ViewController:CLLocationManagerDelegate{
    //位置请求成功,会调用,通过location这个参数获取位置信息,
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lon = locations[0].coordinate.longitude
        let lat = locations[0].coordinate.latitude
        //
        print(lon,lat)
        //回调函数,自动调用,responsejasn,闭包,response接收天气信息参数
        //异步执行,开辟一条新路
        AF.request(kQweatherNowpath,parameters: getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value{
                self.activityIndicator.stopAnimating()
                //结束加载动画
                
                let weatherJSON = JSON(data)//源于依赖包的方法,然后可以[]取值
                self.showWeather(weatherJSON)
                print("showweather")
                //回调函数内的全局变量,以及viewcontroller的方法,需要加self
                //先改变变量(model),再改变ui(mvc)
                
                print(weatherJSON["now"]["temp"].stringValue)
                print(weatherJSON["now"]["icon"].stringValue)
            }
        }
        
        AF.request(kQweatherCitypath,parameters: getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value{
                let cityJSON = JSON(data)
                self.showCity(cityJSON)
                print(cityJSON["location"][0]["name"].stringValue)
                //调用当前视图控制器的showCity方法，并将解析后的城市信息cityJSON作为参数传递给该方法。showCity方法可能会根据传入的城市信息更新界面上的城市名称显示等操作
//                self.weather.city = cityJSON["location"][0]["name"].stringValue
//                self.cityLabel.text = self.weather.city
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error")
        citylabel.text = "获取位置失败"
        if let clError = error as? CLError {
                switch clError.code {
                case .locationUnknown:
                    print("位置未知（通常为临时状态）")
                case .denied:
                    print("用户拒绝了位置权限")
                    manager.stopUpdatingLocation()
                case .network:
                    print("网络错误（如连接失败）")
                default:
                    print("位置错误: \(clError.localizedDescription)")
                }
            } else {
                print("未知错误: \(error.localizedDescription)")
            }
    
    }
}
