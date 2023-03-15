//
//  CityCurrentWeather.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import MeteoWeatherData

// Data Transfer Object between app layer and data layer
struct CityCurrentWeatherOutput {
    let name: String
    let country: String
    let weatherIcon: String
    let weatherDescription: String
    let temperature: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
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
    let oneHourSnow: Double
    let lastUpdateTime: Int
    
    init(with city: CityCurrentWeatherEntity) {
        self.name = city.name ?? "Ville inconnue"
        self.country = city.country ?? ""
        self.weatherIcon = city.weatherIcon ?? ""
        self.weatherDescription = city.weatherDescription ?? "Aucune description"
        self.temperature = city.temperature
        self.feelsLike = city.feelsLike
        self.tempMin = city.tempMin
        self.tempMax = city.tempMax
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
        self.oneHourSnow = city.oneHourSnow
        self.lastUpdateTime = Int(city.lastUpdateTime)
    }
    
    init(with city: CityCurrentWeatherLocalEntity) {
        self.name = city.name
        self.country = city.country
        self.weatherIcon = city.weatherIcon
        self.weatherDescription = city.weatherDescription
        self.temperature = city.temperature
        self.feelsLike = city.feelsLike
        self.tempMin = city.tempMin
        self.tempMax = city.tempMax
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
        self.oneHourSnow = city.oneHourSnow
        self.lastUpdateTime = Int(city.lastUpdateTime)
    }
    
    init(name: String, country: String, weatherIcon: String, weatherDescription: String, temperature: Double, feelsLike: Double, tempMin: Double, tempMax: Double, lon: Double, lat: Double, sunset: Int, sunrise: Int, pressure: Int, humidity: Int, cloudiness: Int, windSpeed: Double, windGust: Double, oneHourRain: Double, oneHourSnow: Double, lastUpdateTime: Int) {
        self.name = name
        self.country = country
        self.weatherIcon = weatherIcon
        self.weatherDescription = weatherDescription
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.lon = lon
        self.lat = lat
        self.sunset = sunset
        self.sunrise = sunrise
        self.pressure = pressure
        self.humidity = humidity
        self.cloudiness = cloudiness
        self.windSpeed = windSpeed
        self.windGust = windGust
        self.oneHourRain = oneHourRain
        self.oneHourSnow = oneHourSnow
        self.lastUpdateTime = lastUpdateTime
    }
    
    func getCityViewModel() -> ListEntity.ViewModel.CityViewModel {
        return ListEntity.ViewModel.CityViewModel(
            name: self.name,
            weatherDescription: self.weatherDescription.prefix(1).capitalized + self.weatherDescription.dropFirst().lowercased() ,
            iconImage: self.weatherIcon,
            temperature: parseTemperature(with: self.temperature),
            minTemperature: self.tempMin != -999 ? parseTemperature(with: self.tempMin) : nil,
            maxTemperature: self.tempMax != -999 ? parseTemperature(with: self.tempMax) : nil
        )
    }
}
