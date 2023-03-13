//
//  CityWeatherTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit
import MeteoWeatherData

final class CityWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    func setView() {
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: ListEntity.ViewModel.CityViewModel) {
        setView()
        cityNameLabel.text = viewModel.name
        weatherDescriptionLabel.text = viewModel.weatherDescription
        temperatureLabel.text = viewModel.temperature
        weatherIconImage.image = UIImage(named: viewModel.iconImage)
    }
}
