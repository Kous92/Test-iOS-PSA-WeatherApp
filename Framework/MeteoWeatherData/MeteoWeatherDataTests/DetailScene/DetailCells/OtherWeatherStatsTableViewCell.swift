//
//  OtherWeatherStatsTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import UIKit

class OtherWeatherStatsTableViewCell: UITableViewCell {

    // Set the identifier for the custom cell
    static let identifier = "otherCell"

    // Returning the XIB file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var weatherStatLabel: UILabel!
    @IBOutlet weak var weatherStatImage: UIImageView!
    @IBOutlet weak var cellFrame: UIView!
    
    func setView() {
        self.selectionStyle = .none
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: DetailEntity.WeatherDetails.OtherWeatherStatsViewModel) {
        setView()
        weatherStatLabel.text = "\(viewModel.description): \(viewModel.value)"
        weatherStatImage.image = UIImage(systemName: viewModel.imageName)
    }
}
