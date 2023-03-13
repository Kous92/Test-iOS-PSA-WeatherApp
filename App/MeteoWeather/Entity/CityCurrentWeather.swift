//
//  CityCurrentWeather.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import MeteoWeatherData

struct CityCurrentWeather {
    let name: String
    let country: String
    let weatherIcon: String
    let weatherDescription: String
    let temperature: Double
    let lon: Double
    let lat: Double
    let sunset: Int
    let sunrise: Int
    let pressure: Int
    let humidity: Int
    let cloudiness: Int
    let windSpeed: Double
    let windGust: Double
    let oneHourRain: Double
    let threeHourRain: Double
    let oneHourSnow: Double
    let threeHourSnow: Double
    
    init(with city: CityCurrentWeatherEntity) {
        self.name = city.name ?? "Ville inconnue"
        self.country = city.country ?? "(??)"
        self.weatherIcon = city.weatherIcon ?? ""
        self.weatherDescription = city.weatherDescription ?? "Aucune description"
        self.temperature = city.temperature
        self.lon = city.lon
        self.lat = city.lat
        self.sunset = Int(city.sunset)
        self.sunrise = Int(city.sunrise)
        self.pressure = Int(city.pressure)
        self.humidity = Int(city.humidity)
        self.cloudiness = Int(city.cloudiness)
        self.windSpeed = city.windSpeed
        self.windGust = city.windGust
        self.oneHourRain = city.oneHourRain
        self.threeHourRain = city.threeHourRain
        self.oneHourSnow = city.oneHourSnow
        self.threeHourSnow = city.threeHourSnow
    }
    
    func getCityViewModel() -> ListEntity.ViewModel.CityViewModel {
        return ListEntity.ViewModel.CityViewModel(
            name: self.name,
            weatherDescription: self.weatherDescription.prefix(1).capitalized + self.weatherDescription.dropFirst().lowercased() ,
            iconImage: self.weatherIcon,
            temperature: parseTemperature()
        )
    }
    
    func parseTemperature() -> String {
        return "\(Int(round(self.temperature)))°C"
    }
}
