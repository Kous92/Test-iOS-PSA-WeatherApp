//
//  CityWeatherTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit

final class CityWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var minMaxTempStackView: UIStackView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    func setView() {
        cellFrame.layer.cornerRadius = 10
        self.selectionStyle = .none
    }
    
    func setMinMaxTempView(min: String?, max: String?) {
        guard let min, let max else {
            minMaxTempStackView.removeFromSuperview()
            return
        }
        
        minTemperatureLabel.text = min
        maxTemperatureLabel.text = max
    }
    
    func configure(with viewModel: ListEntity.ViewModel.CityViewModel) {
        setView()
        cityNameLabel.text = viewModel.name
        weatherDescriptionLabel.text = viewModel.weatherDescription
        temperatureLabel.text = viewModel.temperature
        weatherIconImage.image = UIImage(named: viewModel.iconImage)
        setMinMaxTempView(min: viewModel.minTemperature, max: viewModel.maxTemperature)
    }
}
