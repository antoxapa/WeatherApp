//
//  NetworkManager.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private init() {}
    
    static let shared: NetworkManager = NetworkManager()
    private var decoder = JSONDecoder()
    private var decoderOfferModel: OfferModel?
    
    func getWeather(result: @escaping ((OfferModel?) -> Void), onError: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: "53.893009"),
                                    URLQueryItem(name: "lon", value: "27.567444"),
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
            
            if data != nil {
                self.decoderOfferModel = try? self.decoder.decode(OfferModel.self, from: data!)
            }
            
            result(self.decoderOfferModel)
            
        }.resume()
        
    }
    
}

