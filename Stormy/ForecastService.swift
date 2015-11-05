//
//  ForecastService.swift
//  Stormy
//
//  Created by Kapil Rathore on 05/11/15.
//  Copyright © 2015 Kapil Rathore. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, lon: Double, completion: (Forecaste? -> Void)) {
        
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forecastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let forecaste = Forecaste(weatherDictionary: JSONDictionary)
                completion(forecaste)
            }
        } else {
            print("Could not construct a valid URL")
        }
    }
}
