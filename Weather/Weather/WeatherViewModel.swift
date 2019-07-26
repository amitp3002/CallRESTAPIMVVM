//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Amit Patel on 7/25/19.
//  Copyright © 2019 Amit Patel. All rights reserved.
//

import Foundation
import UIKit


class WeatherViewModel {
    var city:String
    var country:String
    var currentTemperature:Int?
    var weatherCondition:String?
    var weatherImage:UIImage?
    var imagePath:String
    
    private struct Constants {
        static let imageBaseURL = "https://openweathermap.org/img/wn/" // image name e.g. 10d@2x.png
    }
    
    init(city:String, country:String, temperature:Int = 0, conditions:String = "") {
        self.city = city
        self.country = country
        currentTemperature = temperature
        weatherCondition = conditions
        self.imagePath = ""
        

        let weatherDataModel = WeatherDataModel(city: self.city, country: self.country)
        weatherDataModel.getWeather { [weak self] (data, response, error) in
            if error == nil {
                if let weatherData = data {
                    self?.currentTemperature = Int(weatherData.main.temp)
                    self?.weatherCondition = weatherData.weather[0].description
                    self?.imagePath = Constants.imageBaseURL + weatherData.weather[0].icon + "@2x.png"
                    self?.downloadImage()

                }
            }
        }
   
    }
    
    deinit {
        print("No retain cylce")
    }
    
    private func downloadImage() {
        let session = URLSession.shared
        let url = URL(string: imagePath)
        if let urlPath = url {
            let sessionTask = session.downloadTask(with: urlPath) { [weak self] (localURL, response, error) in
                if error == nil {
                    if let result = localURL {
                        do {
                            let data = try Data(contentsOf: result)
                            self?.weatherImage = UIImage(data: data)
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WeatherUpdatedNotifcation"), object: nil)
                            }
                            
                        } catch {
                            return
                        }
                   }
                }
            }
            sessionTask.resume()
        }
    }
}
