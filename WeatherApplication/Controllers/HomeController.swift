//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 22/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherModel: WeatherModel! {
        didSet {
            nameLabel.text = weatherModel.name
            dateLabel.text = weatherModel.day
            tempLabel.text = "\(weatherModel.temperature ?? 10)"
            minTemp.text = "Мин \(weatherModel.minimumTemperature ?? 2)"
            maxTemp.text = "Макс \(weatherModel.maximumTemperature ?? 3)"
            humadityLabel.text = "Влажность \(weatherModel.humidity ?? 12)%"
            windLabel.text = "Ветер \(weatherModel.windSpeed ?? 0) м/c"
            sunsetLabel.text = String(weatherModel.sunrise ?? "0")
            sunriseLabel.text = String(weatherModel.sunset ?? "0")
            descriptionLabel.text = weatherModel.description?.firstUppercased
            guard let iconName = weatherModel.icon else { return }
            iconImage.image = UIImage(named: iconName)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchWeather()
        getBackGround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func fetchWeather() {
        APIService.shared.downloadData { (weatherModel) in
            self.weatherModel = weatherModel
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func getBackGround() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH")
        let hour = dateFormatter.string(from: date)
        let myTime = Int(hour)
        
        if (myTime! >= 0) && (myTime! < 6) {
            view.backgroundColor = #colorLiteral(red: 0.091043904, green: 0.1818169142, blue: 0.3799571701, alpha: 1)
        } else if (myTime! > 6) && (myTime! < 20) {
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else if (myTime! >= 20) && (myTime! <= 23) {
            view.backgroundColor = #colorLiteral(red: 0.151430261, green: 0.3095761044, blue: 0.6613459709, alpha: 1)
        }
    }
}

