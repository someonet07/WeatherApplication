//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Тимур Чеберда on 22/04/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import UIKit
import Charts

class HomeController: UIViewController {
    
    
    @IBOutlet weak var weatherChartView: LineChartView!
    @IBOutlet weak var backgroundImage: UIImageView!
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
    
    private var weatherForecast = [WeatherForecast]()
    
    private var weatherModel: WeatherModel! {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchWeather()
        getBackGround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChartData()
    }
    //MARK:- Json data
    fileprivate func fetchWeather() {
        APIService.shared.downloadData { (weatherModel) in
            self.weatherModel = weatherModel
        }
        APIService.shared.downloadForecast { (forecastModel) in
            self.weatherForecast.append(forecastModel)
            print(forecastModel.day ?? 2)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Dynamic background
    fileprivate func getBackGround() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH")
        let hour = dateFormatter.string(from: date)
        let myTime = Int(hour)
        
        if (myTime! >= 0) && (myTime! < 6) {
            backgroundImage.image = #imageLiteral(resourceName: "early_background")
        } else if (myTime! > 6) && (myTime! < 20) {
            backgroundImage.image = #imageLiteral(resourceName: "day_background")
        } else if (myTime! >= 20) && (myTime! <= 23) {
            backgroundImage.image = #imageLiteral(resourceName: "night_background")
        }
    }
    //MARK:- Chart
    //TODO:- correct time and get data from json
    fileprivate func fetchChartData() {
        let xAxis = weatherChartView.xAxis
        xAxis.labelPosition = .top
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelTextColor = .white
        
        let value = (0..<6).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(20)) + 8)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "01d"))
        }
        
        let leftAxis = weatherChartView.leftAxis
        leftAxis.labelTextColor = .white
        leftAxis.axisMaximum = 40
        leftAxis.axisMinimum = 0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        
        let rightAxis = weatherChartView.rightAxis
        rightAxis.labelTextColor = .white
        rightAxis.axisMaximum = 40
        rightAxis.axisMinimum = 0
        rightAxis.granularityEnabled = false
        
        let set1 = LineChartDataSet(entries: value, label: "Rostov-na-Donu")
        set1.mode = .cubicBezier
        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(.systemFont(ofSize: 0))
        weatherChartView.data = data
    }
}
