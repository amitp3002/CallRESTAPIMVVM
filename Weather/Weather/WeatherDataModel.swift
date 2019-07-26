//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Amit Patel on 7/25/19.
//  Copyright © 2019 Amit Patel. All rights reserved.
//

import Foundation


// The following structs are defined based on the JSON response below:

 /*   "coord": {
 "lon": -122.08,
 "lat": 37.39
 },
 "weather": [
 {
 "id": 800,
 "main": "Clear",
 "description": "clear sky",
 "icon": "01d"
 }
 ],
 "base": "stations",
 "main": {
 "temp": 296.71,
 "pressure": 1013,
 "humidity": 53,
 "temp_min": 294.82,
 "temp_max": 298.71
 },
 "visibility": 16093,
 "wind": {
 "speed": 1.5,
 "deg": 350
 },
 "clouds": {
 "all": 1
 },
 "dt": 1560350645,
 "sys": {
 "type": 1,
 "id": 5122,
 "message": 0.0139,
 "country": "US",
 "sunrise": 1560343627,
 "sunset": 1560396563
 },
 "timezone": -25200,
 "id": 420006353,
 "name": "Mountain View",
 "cod": 200
 }
 */

struct Coordinates : Decodable {
    let lon:Double
    let lat:Double
}

struct Weather : Decodable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}

struct Main : Decodable {
    let temp:Double
    let pressure:Int
    let humidity:Int
    let temp_min:Double
    let temp_max:Double
}

struct Wind : Decodable {
    let speed:Double
    let deg:Int
}

struct Cloud : Decodable {
    let all:Int
}

struct System : Decodable {
    let type:Int
    let id:Int
    let message:Double
    let country:String
    let sunrise:UInt
    let sunset:UInt
}

struct WeatherData : Decodable {
    let coord:Coordinates
    let weather:[Weather]
    let main:Main
    let base:String
    let wind:Wind
    let visibility:Int
    let clouds:Cloud
    let sys:System
    let timezone:Int
    let id:UInt
    let name:String
    let cod:Int
}

// The Model in MVVM.  This class calls a REST API to get weather info for a given city
class WeatherDataModel {
    
    var city:String
    var country:String // use ISO 3166 country codes
    private struct Constants {
        static let key = "a2d4ea343a22e6e7aa605019259b4182"  // This API key should ideally be obtained from a backend server.
        static let endpoint = "https://api.openweathermap.org/data/2.5/weather?q="
        static let units = "imperial" // This should be configurable based on users preferences.
    }
    
    init(city:String, country:String) {
        self.city = city
        self.country = country
    }
    
    deinit {
        print("No retain cycles!")
    }
    
    func getWeather(completionHandler:@escaping(_ result:WeatherData?, _ response:URLResponse?, _ error:Error?)->Void)  {
        
        guard let encodedCity = self.city.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            let err = NSError(domain: "", code: -1, userInfo: ["Error":"Could not url encode city"])
            completionHandler(nil, nil, err)
            return
        }
        //api.openweathermap.org/data/2.5/weather?q=city,country&APPID=a2d4ea343a22e6e7aa605019259b4182
        var fullEndpoint = Constants.endpoint
        fullEndpoint += encodedCity + "," + self.country + "&APPID=" + Constants.key + "&units=" + Constants.units
       
        let session = URLSession.shared
    
        if let url = URL(string: fullEndpoint) {
            let sessionTask = session.dataTask(with: url) { (result, response, error) in
                
                if error == nil {
                    if let data = result {
                        do {
                            let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                            completionHandler(weather, response, error)
                        } catch {
                            let err = NSError(domain: "", code: -1, userInfo: ["Error":"JSON parsing error"])
                            completionHandler(nil, nil, err)
                            return
                        }
                    } else {
                        completionHandler(nil, response, error)
                    }
                }
                else {
                    completionHandler(nil, response, error)
                }
            }
            sessionTask.resume()
        }
    }
}
