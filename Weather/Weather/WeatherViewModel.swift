//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Amit Patel on 7/25/19.
//  Copyright © 2019 Amit Patel. All rights reserved.
//

import Foundation


class WeatherViewModel {
    var city:String
    var country:String
    var currentTemperature:Int?
    var weatherCondition:String?
    
    init(city:String, country:String, temperature:Int = 0, conditions:String = "") {
        self.city = city
        self.country = country
        currentTemperature = temperature
        weatherCondition = conditions
        
        let weatherDataModel = WeatherDataModel(city: self.city, country: self.country)
        weatherDataModel.getWeather { [weak self] (data, response, error) in
            if error == nil {
                if let weatherData = data {
                    self?.currentTemperature = Int(weatherData.main.temp)
                    self?.weatherCondition = weatherData.weather[0].description
                }
            }
        }
   
    }
    
    deinit {
        print("No retain cylce")
    }
}
