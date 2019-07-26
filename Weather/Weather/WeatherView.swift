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
        static let marginPadding:CGFloat = 16
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
        setupImageView()
        setupLabels()
    }
    
    
    private func setupViewAttributes() {
        iconView.layer.cornerRadius = Constants.cornerRadius
        iconView.layer.masksToBounds = true
        self.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageView() {
        if let sv = superview {
            iconView.topAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.topAnchor).isActive = true
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
        conditionsLabel.text = NSLocalizedString("Two happy dogs standing on green\n grass presumably in a park.", comment: "description label")
        conditionsLabel.font = UIFont(name: Constants.fontName, size: Constants.fontSize)
        conditionsLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor).isActive = true
        conditionsLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        if let sv = superview {
            conditionsLabel.bottomAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.marginPadding + Constants.marginPadding)).isActive = true
        }
        
        
    }
}

