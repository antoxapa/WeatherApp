//
//  HeaderView.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
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
            degreesLabel.text = "\(newValue)º"
        }
    }
    
    private var maxTemperature: String? {
        get { return maxTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            maxTemperatureLabel.text = "Max. \(newValue)º, "}
    }
    
    private var minTemperature: String? {
        get { return minTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            minTemperatureLabel.text = "min. \(newValue)º"
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
        
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        cityLabel.text = ""
        weatherLabel.text = ""
        degreesLabel.text = "--"
        minTemperatureLabel.text = ""
        maxTemperatureLabel.text = ""
        
    }
    
    func decrementColorAlpha(offset: CGFloat) {
        
        if temperatureStackView.alpha <= 1 {
            let alphaOffset = (offset/500)/85
            temperatureStackView.alpha += alphaOffset
        }
        
    }
    
    func incrementColorAlpha(offset: CGFloat) {
        
        if temperatureStackView.alpha >= 0 {
            let alphaOffset = (offset/200)/85
            temperatureStackView.alpha -= alphaOffset
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
