//
//  RainSnowTableViewCell.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import UIKit

final class RainSnowTableViewCell: UITableViewCell {

    // Set the identifier for the custom cell
    static let identifier = "rainSnowCell"

    // Returning the XIB file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var rainSnowTitle: UILabel!
    @IBOutlet weak var oneHourLabel: UILabel!
    @IBOutlet weak var rainSnowImage: UIImageView!
    @IBOutlet weak var cellFrame: UIView!
    
    func setView() {
        self.selectionStyle = .none
        cellFrame.layer.cornerRadius = 10
    }
    
    func configure(with viewModel: DetailEntity.WeatherDetails.RainSnowViewModel) {
        setView()
        rainSnowTitle.text = viewModel.type
        oneHourLabel.text = "Dernière heure: \(viewModel.oneHourVolume)"
        rainSnowImage.image = UIImage(systemName: viewModel.type == "Neige" ? "snow" : "cloud.rain.fill")
    }
}
