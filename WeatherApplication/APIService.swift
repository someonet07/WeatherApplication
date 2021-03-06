//
//  APIService.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 22/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    // daily weather
    private let apiKeyWeather =  "http://api.openweathermap.org/data/2.5/weather?id=501175&lang=ru&units=metric&appid=a71f8f08804055adde2321a93f3544eb"
    
    // forecast weather
    private let apiKeyForecast = "http://api.openweathermap.org/data/2.5/forecast?id=501175&units=metric&appid=a71f8f08804055adde2321a93f3544eb"
    
    static let shared = APIService()
    
    func downloadForecast(completionHandler: @escaping (WeatherForecast) -> ()) {
        Alamofire.request(apiKeyForecast).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("value", value)
                let result = response.result
                let json = JSON(result.value ?? "")
                for item in json["list"].arrayValue {
                    let items = item.dictionaryObject
                    let forecast = WeatherForecast(weatherDictionary: items!)
                    completionHandler(forecast)}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func downloadData(completionHandler: @escaping (WeatherModel) -> ()) {
        Alamofire.request(apiKeyWeather).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("value", value)
                let json = JSON(response.value ?? "")
                var weatherModel = WeatherModel()
                guard let dateFormat = json["dt"].double else { return }
                let convertDate = Date(timeIntervalSince1970: dateFormat)
                guard let timeSunset = json["sys"]["sunset"].double else { return }
                let convertSunset = Date(timeIntervalSince1970: timeSunset)
                guard let timeSunrise = json["sys"]["sunrise"].double else { return }
                let convertSunrise = Date(timeIntervalSince1970: timeSunrise)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .short
                weatherModel.day = dateFormatter.string(from: convertDate)
                weatherModel.sunset = timeFormatter.string(from: convertSunset)
                weatherModel.sunrise = timeFormatter.string(from: convertSunrise)
                weatherModel.name = json["name"].stringValue
                weatherModel.icon = json["weather"][0]["icon"].stringValue
                weatherModel.temperature = json["main"]["temp"].intValue
                weatherModel.minimumTemperature = json["main"]["temp_min"].intValue
                weatherModel.maximumTemperature = json["main"]["temp_max"].intValue
                weatherModel.windSpeed = json["wind"]["speed"].intValue
                weatherModel.description = json["weather"][0]["description"].stringValue
                weatherModel.humidity = json["main"]["humidity"].intValue
                completionHandler(weatherModel)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
