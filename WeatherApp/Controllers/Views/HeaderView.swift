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
    
    var locationName: String? {
        get { return cityLabel?.text }
        set { cityLabel.text = newValue }
    }
    
    var currentWeather: String? {
        get { return weatherLabel?.text }
        set { weatherLabel.text = newValue }
    }
    
    var temperature: String? {
        get { return degreesLabel?.text }
        set {
            guard let newValue = newValue else { return }
            degreesLabel.text = "\(newValue)º"
        }
    }
    
    var maxTemperature: String? {
        get { return maxTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            maxTemperatureLabel.text = "Max.\(newValue)º,"}
    }
    
    var minTemperature: String? {
        get { return minTemperatureLabel?.text }
        set {
            guard let newValue = newValue else { return }
            minTemperatureLabel.text = "min.\(newValue)º"
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
    
}
