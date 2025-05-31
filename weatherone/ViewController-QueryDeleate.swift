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
            //let parameters = getParameters(city)
            AF.request(kQweatherCitypath,parameters:getParameters(city)).responseJSON { response in
                if let data = response.value{
                    let cityJSON = JSON(data)
                    self.showCity(cityJSON)


                    //显示城市名称
                    //let parameters =
                    AF.request(kQweatherNowpath,parameters: self.getParameters(cityJSON["location",0,"id"].stringValue)).responseJSON { response in
                        if let data = response.value{
                            let weatherJSON = JSON(data)
                            self.showWeather(weatherJSON)

                            //显示天气
                        }
                    }
                }
            }
        }
    
}
