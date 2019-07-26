//
//  ViewController.swift
//  Weather
//
//  Created by Amit Patel on 7/25/19.
//  Copyright © 2019 Amit Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var weatherView:WeatherView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView = WeatherView()
        if let wv = weatherView {
            // Do any additional setup after loading the view.
            view.addSubview(wv)
            wv.setupView()
        }
        // Do any additional setup after loading the view.
        let weather = WeatherViewModel(city:"Santa Clara", country: "us")
        
        DispatchQueue.main.async {
            if let temp = weather.currentTemperature {
                // update UI with current temp
            }
            if let condition = weather.weatherCondition {
                // update UI with current weather conditions
            }
        }
    }
}

