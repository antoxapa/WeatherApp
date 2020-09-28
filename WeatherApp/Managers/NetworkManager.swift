//
//  NetworkManager.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private var decoder = JSONDecoder()
    private var decoderOfferModel: OfferModel?
    
    func getWeather(forLatitude latitude: Double, longitude: Double, result: @escaping ((OfferModel?) -> Void), onError: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                                    URLQueryItem(name: "lon", value: "\(longitude)"),
                                    URLQueryItem(name: "units", value: "metric"),
                                    URLQueryItem(name: "exclude", value: "minutely"),
                                    URLQueryItem(name: "appid", value: Constants.API.API_KEY)
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, nil, error) in
            
            if error != nil {
                onError(error)
                return
            }
            
            if let data = data {
                do {
                self.decoderOfferModel = try self.decoder.decode(OfferModel.self, from: data)
                } catch {
                    onError(error)
                    return
                }
            }
            result(self.decoderOfferModel)
            
        }.resume()
        
    }
    
    func getWeatherImage(forIcon icon: String, result: @escaping ((Data) -> Void), onError: @escaping (Error?) -> Void) {
        
        guard let url = URL(string: "http://openweathermap.org/img/w/" + "\(icon)" + ".png") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, nil, error) in
            
            if error != nil {
                onError(error)
                return
            }
            
            if let data = data {
                result(data)
            }
            
        }.resume()
        
    }
    
}

