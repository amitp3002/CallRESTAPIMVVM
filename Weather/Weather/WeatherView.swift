//
//  WeatherView.swift
//  Weather
//
//  Created by Amit Patel on 7/25/19.
//  Copyright © 2019 Amit Patel. All rights reserved.
//

import Foundation
import UIKit


// This is the View class in MVVM.  Class shows a custom view with image and labels
class WeatherView : UIView {
    
    private struct Constants /* this can be renamed UserInterfaceStyles and moved out and reused throughout the app */ {
        static let marginPadding:CGFloat = 20
        static let cornerRadius:CGFloat = 5
        static let imageSize:CGFloat = 230
        static let fontName = "HelveticaNeue-Bold"
        static let fontSize:CGFloat = 18
    }
    
    var iconView:UIImageView
    var temperatureLabel:UILabel
    var conditionsLabel:UILabel
    var locationLabel:UILabel

    
    override init(frame: CGRect) {
        self.iconView = UIImageView()
        self.temperatureLabel = UILabel(frame: frame)
        self.conditionsLabel = UILabel(frame: frame)
        self.locationLabel = UILabel(frame: frame)
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupViewAttributes()
        setupLabels()
        setupImageView()
    }
    
    
    private func setupViewAttributes() {
        iconView.layer.cornerRadius = Constants.cornerRadius
        iconView.layer.masksToBounds = true
        self.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageView() {
        if let sv = superview {
            iconView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Constants.marginPadding).isActive = true
            let constraint = NSLayoutConstraint(item: iconView,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: sv,
                                                attribute: .leading,
                                                multiplier: 1, constant: Constants.marginPadding)
            
            constraint.isActive = true
            sv.addConstraint(constraint)
            iconView.widthAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
            iconView.heightAnchor.constraint(equalToConstant:Constants.imageSize).isActive = true
        }
    }
    
    
    private func setupLabels() {
        self.addSubview(conditionsLabel)
        conditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionsLabel.numberOfLines = 0
        conditionsLabel.text = NSLocalizedString("Current Conditions: ", comment: "description label")
        let myFont = UIFont(name: Constants.fontName, size: Constants.fontSize)
        conditionsLabel.font = myFont
        conditionsLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor).isActive = true
        conditionsLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        self.addSubview(self.locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.numberOfLines = 1
        locationLabel.font = myFont
        
        self.addSubview(self.temperatureLabel)
        temperatureLabel.numberOfLines = 1
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = myFont
        temperatureLabel.text = NSLocalizedString("High Temperature: ", comment:"temperature label")
        if let sv = superview {
            conditionsLabel.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: (Constants.marginPadding + Constants.marginPadding)).isActive = true
            locationLabel.topAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.topAnchor, constant: Constants.marginPadding).isActive = true
            locationLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor).isActive = true
            locationLabel.heightAnchor.constraint(equalToConstant: Constants.marginPadding).isActive = true
            temperatureLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor).isActive = true
            temperatureLabel.heightAnchor.constraint(equalToConstant: Constants.marginPadding).isActive = true
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.marginPadding).isActive = true
        }
        
        
    }
}

