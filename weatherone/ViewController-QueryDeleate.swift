//
//  ViewController-QueryDeleate.swift
//  weatherone
//
//  Created by huqy on 2025/5/31.
//
import Alamofire
import SwiftyJSON
import UIKit
import Foundation

extension ViewController:QueryViewControllerDelegate{
    
        func didchangecity(city:String){
            print("当前查询城市:\(city)")
            self.activityIndicator.startAnimating()
            print("开始加载动画")
            AF.request(kQweatherCitypath,parameters:getParameters(city)).responseJSON { response in
                if let data = response.value{
                    let cityJSON = JSON(data)
                    self.showCity(cityJSON)
                    
                    AF.request(kQweatherNowpath,parameters: self.getParameters(cityJSON["location",0,"id"].stringValue)).responseJSON { response in
                        if let data = response.value{
                            let weatherJSON = JSON(data)
                            self.activityIndicator.stopAnimating()
                            print("结束加载动画")
                            self.showWeather(weatherJSON)
                            

                        }
                    }
                }
            }
        }
    
}
