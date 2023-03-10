//
//  ViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import UIKit
import MeteoWeatherData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let test1 = WeatherData()
        print(test1.getData())
        
        let airPollution = test1.testDecodingAirPollution()
        print("Index qualité de l'air: \(airPollution.list[0].main.aqi)")
        
        let geocoded = test1.testDecodingGeocodedCity()
        print(geocoded)
        
        let cityWeather = test1.testDecodingCurrentWeather()
        print(cityWeather)
    }
}
