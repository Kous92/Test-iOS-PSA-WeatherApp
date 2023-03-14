//
//  TemperatureTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {

    // Set the identifier for the custom cell
    static let identifier = "temperatureCell"
    
    // Returning the XIB file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var temperatureFeelingLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureStackView: UIStackView!
    @IBOutlet weak var maxTemperatureStackView: UIStackView!
    @IBOutlet weak var minMaxStackView: UIStackView!
    
    @IBOutlet weak var cellFrame: UIView!
    
    func setView() {
        self.selectionStyle = .none
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: DetailEntity.WeatherDetails.TemperatureViewModel) {
        setView()
        
        if let feelTemperature = viewModel.feelingTemperature {
            temperatureFeelingLabel.text = "Ressenti: \(feelTemperature)"
        } else {
            temperatureFeelingLabel.removeFromSuperview()
        }
        
        guard viewModel.minTemperature != nil || viewModel.maxTemperature != nil else {
            minMaxStackView.removeFromSuperview()
            return
        }
        
        if let minTemperature = viewModel.minTemperature {
            minTemperatureLabel.text = minTemperature
        } else {
            minTemperatureLabel.removeFromSuperview()
        }
        
        if let maxTemperature = viewModel.maxTemperature {
            maxTemperatureLabel.text = maxTemperature
        } else {
            maxTemperatureLabel.removeFromSuperview()
        }
    }
}
