//
//  viewController-helper.swift
//  weatherone
//
//  Created by huqy on 2025/5/30.
//

import Foundation
import SwiftyJSON
extension ViewController{
    func showWeather(_ weatherJSON:JSON){
        weather.temp = weatherJSON["now"]["temp"].stringValue//源于依赖包,输出string
        weather.icon = weatherJSON["now"]["icon"].stringValue
        weather.text = weatherJSON["now"]["text"].stringValue
        weather.humidity = weatherJSON["now"]["humidity"].stringValue
        weather.vis = weatherJSON["now"]["vis"].stringValue
        weather.windDir = weatherJSON["now"]["windDir"].stringValue
        weather.windScale = weatherJSON["now"]["windScale"].stringValue
        
        if let visint = Int(weather.vis){
            if visint <= 8{
                self.setGrayGradientBackground()
            }else{
                self.setBlueGradientBackground()
            }
        }
        //根据天气能见度设置背景
        
        iconimagefield.image = UIImage(named: self.weather.icon)
        icontextlabel.text = self.weather.text
        templabel.text = self.weather.temp
        humiditylabel.text = "相对湿度:\(self.weather.humidity)%"
        vislabel.text = "能见度:\(self.weather.vis)km"
        windDirlabel.text = "风向:\(self.weather.windDir)"
        windScalelabel.text = "风力等级:\(self.weather.windScale)级"
        print(weatherJSON["now"]["temp"].stringValue)
        print(weatherJSON["now"]["icon"].stringValue)
        
    }
    func showCity(_ cityJSON:JSON){
        weather.city = cityJSON["location"][0]["name"].stringValue
        citylabel.text = self.weather.city
    }
    func getParameters(_ location:String)-> [String:String]{
        return ["location":location,"key":kQweatherWebKey]
    }
}
