//
//  DetailViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit
import MeteoWeatherData

class DetailViewController: UIViewController {
    
    var cityWeather: CityCurrentWeatherEntity?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = cityWeather?.name ?? "Lieu inconnu"
        
        if let temp = cityWeather?.temperature {
            tempLabel.text = "\(Int(temp))°C"
        } else {
            tempLabel.text = "Température indisponible"
        }
        
        iconImageView.image = UIImage(named: cityWeather?.weatherIcon ?? "xmark.icloud.fill")
        
        weatherDescription.text = cityWeather?.weatherDescription ?? "Aucune information"
    }
}
