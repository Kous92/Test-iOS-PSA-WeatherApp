//
//  SunsetSunriseTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import UIKit

class SunsetSunriseTableViewCell: UITableViewCell {

    // Set the identifier for the custom cell
    static let identifier = "sunsetSunriseCell"

    // Returning the XIB file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var cellFrame: UIView!
    
    func setView() {
        self.selectionStyle = .none
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: DetailEntity.WeatherDetails.SunsetSunriseViewModel) {
        setView()
        sunriseTimeLabel.text = "Lever: \(viewModel.sunrise)"
        sunsetTimeLabel.text = "Coucher: \(viewModel.sunset)"
    }
}
