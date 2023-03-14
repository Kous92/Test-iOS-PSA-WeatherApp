//
//  WindTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import UIKit

final class WindTableViewCell: UITableViewCell {

    // Set the identifier for the custom cell
    static let identifier = "windCell"

    // Returning the XIB file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windGustLabel: UILabel!
    @IBOutlet weak var cellFrame: UIView!
    
    func setView() {
        self.selectionStyle = .none
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: DetailEntity.WeatherDetails.WindViewModel) {
        setView()
        windSpeedLabel.text = "Vitesse: \(viewModel.windSpeed ?? "0")"
        windGustLabel.text = "Rafale: \(viewModel.windGust ?? "0")"
    }
}
