//
//  HeaderView.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class MainWeatherHeaderView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var degreesLabel: UILabel!
    
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet private weak var temperatureStackView: UIStackView!
    @IBOutlet private weak var mainStackView: UIStackView!
    
    private var locationName: String? {
        get { return cityLabel?.text }
        set { cityLabel.text = newValue }
    }
    
    private var currentWeather: String? {
        get { return weatherLabel?.text }
        set { weatherLabel.text = newValue }
    }
    
    private var temperature: String? {
        get { return degreesLabel?.text }
        set {
            guard let newValue = newValue else { return }
            degreesLabel.text = "\(newValue)\(i20n.degreesString)"
        }
    }
    
    private var maxTemperature: String? {
        get { return maxTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            maxTemperatureLabel.text = "\(i20n.maxString) \(newValue)\(i20n.degreesString), "}
    }
    
    private var minTemperature: String? {
        get { return minTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            minTemperatureLabel.text = "\(i20n.minString) \(newValue)\(i20n.degreesString)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        
    }
    
    private func initSubviews() {
        
        let nib = UINib(nibName: "MainWeatherHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        cityLabel.text = ""
        weatherLabel.text = ""
        degreesLabel.text = "--"
        minTemperatureLabel.text = ""
        maxTemperatureLabel.text = ""
        
    }
    
    func updateLabelsAlpha(using offset: CGFloat) {
        
        guard offset > 0 else {
            [degreesLabel, minTemperatureLabel, maxTemperatureLabel].forEach {
                $0.alpha = 1.0
            }
            return
        }
        
        let degreesCoefficient = offset / 100
        degreesLabel.alpha = max(1.0 - degreesCoefficient, 0.0)
        
        let temperatureCoefficient = offset / 100 + 0.2
        [minTemperatureLabel, maxTemperatureLabel].forEach {
            $0?.alpha = max(1.0 - temperatureCoefficient, 0.0)
        }
        
    }
    
    func updateViews(withItem item: CurrentWeatherItem) {
        
        locationName = item.locationName
        currentWeather = item.weatherDescription
        temperature = item.temperature
        maxTemperature = item.maxTemperature
        minTemperature = item.minTemperature
        
    }
    
}
