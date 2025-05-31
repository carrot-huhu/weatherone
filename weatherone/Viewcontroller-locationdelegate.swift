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
    //位置请求成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lon = locations[0].coordinate.longitude
        let lat = locations[0].coordinate.latitude
        //
        print(lon,lat)
        
        AF.request(kQweatherNowpath,parameters: getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value{
                self.activityIndicator.stopAnimating()
                //结束加载动画
                print("结束加载动画")
                
                let weatherJSON = JSON(data)
                self.showWeather(weatherJSON)
                print("showweather")
                
            }
        }
        
        AF.request(kQweatherCitypath,parameters: getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value{
                let cityJSON = JSON(data)
                self.showCity(cityJSON)
                print(cityJSON["location"][0]["name"].stringValue)
                
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
