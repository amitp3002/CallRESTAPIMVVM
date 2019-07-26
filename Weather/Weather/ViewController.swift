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
        let city = "Santa Clara"
        let country = "usa"
        let weather = WeatherViewModel(city:city, country: country)
        weatherView?.locationLabel.text = city + " " + country.uppercased()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "WeatherUpdatedNotifcation"), object: nil, queue: .main, using: { [weak self] (notification) in
            // Update UI
            DispatchQueue.main.async {
                if let condition = weather.weatherCondition {
                    if let currentText = self?.weatherView?.conditionsLabel.text {
                        self?.weatherView?.conditionsLabel.text = currentText + condition
                    } else {
                        self?.weatherView?.conditionsLabel.text = condition
                    }
                }
                if let tempurature = weather.currentTemperature {
                    let unit = "Fahrenheit"
                    if let currentText = self?.weatherView?.temperatureLabel.text {
                        self?.weatherView?.temperatureLabel.text = currentText + String(tempurature) + " " + unit
                    } else {
                        self?.weatherView?.temperatureLabel.text = String(tempurature) + " " + unit
                    }
                }
                if let image = weather.weatherImage {
                    self?.weatherView?.iconView.image = image
                }
            }
        })
    }
}

