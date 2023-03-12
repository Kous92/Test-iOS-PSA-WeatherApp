//
//  CityWeatherTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit
import MeteoWeatherData

class CityWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    func setView() {
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with city: CityCurrentWeatherEntity) {
        setView()
        cityNameLabel.text = city.name ?? "Lieu inconnu"
        weatherDescriptionLabel.text = city.weatherDescription ?? "Aucune information"
        temperatureLabel.text = "\(Int(city.temperature))°C"
        weatherIconImage.image = UIImage(named: city.weatherIcon ?? "xmark.icloud.fill")
    }
}
