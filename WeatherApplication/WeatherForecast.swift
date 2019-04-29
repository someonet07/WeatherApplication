//
//  WeatherForecast.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 27/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import Foundation

struct WeatherForecast {
    var day: String?
    var temperature: Int?
    
    init (weatherDictionary: Dictionary<String, Any>) {
        if let main = weatherDictionary["main"] as? [String : Any] {
            if let newTemp = main["temp"] as? Double {
                temperature = Int(newTemp)
            }
        }
        if let newDay = weatherDictionary["dt_txt"] as? String {
            day = newDay
        }
    }
}
