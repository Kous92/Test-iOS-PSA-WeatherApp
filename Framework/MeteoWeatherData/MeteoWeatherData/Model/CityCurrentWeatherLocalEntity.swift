//
//  CityentityLocalEntity.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation

// Ensures independence for local entities and testability if Local database service will change
public struct CityCurrentWeatherLocalEntity {
    public let name: String
    public let country: String
    public let weatherIcon: String
    public let weatherDescription: String
    public let temperature: Double
    public let feelsLike: Double
    public let tempMin: Double
    public let tempMax: Double
    public let lon: Double
    public let lat: Double
    public let sunset: Int
    public let sunrise: Int
    public let pressure: Int
    public let humidity: Int
    public let cloudiness: Int
    public let windSpeed: Double
    public let windGust: Double
    public let oneHourRain: Double
    public let oneHourSnow: Double
    public let lastUpdateTime: Int
    
    public init(with geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather) {
        self.country = geocodedCity.country
        self.name = geocodedCity.localNames?["fr"] ?? geocodedCity.name
        self.lat = geocodedCity.lat
        self.lon = geocodedCity.lon
        self.temperature = currentWeather.main?.temp ?? -999
        self.feelsLike = currentWeather.main?.feelsLike ?? -999
        self.tempMin = currentWeather.main?.tempMin ?? -999
        self.tempMax = currentWeather.main?.tempMax ?? -999
        self.weatherDescription = currentWeather.weather?[0].description ?? "Aucune description"
        self.windGust = currentWeather.wind?.gust ?? -1
        self.windSpeed = currentWeather.wind?.speed ?? -1
        self.cloudiness = currentWeather.clouds?.all ?? 0
        self.pressure = currentWeather.main?.pressure ?? -1
        self.humidity = currentWeather.main?.humidity ?? 0
        self.oneHourRain = currentWeather.rain?.oneHour ?? -1
        self.oneHourSnow = currentWeather.snow?.oneHour ?? -1
        self.sunset = currentWeather.sys?.sunset ?? -1
        self.sunrise = currentWeather.sys?.sunrise ?? -1
        self.weatherIcon = currentWeather.weather?[0].icon ?? ""
        self.lastUpdateTime = currentWeather.dt ?? -1
    }
    
    init(entity: CityCurrentWeatherEntity) {
        self.country = entity.country ?? "Inconnu"
        self.name = entity.name ?? "Lieu inconnu"
        self.lat = entity.lat
        self.lon = entity.lon
        self.temperature = entity.temperature
        self.feelsLike = entity.feelsLike
        self.tempMin = entity.tempMin
        self.tempMax = entity.tempMax
        self.weatherDescription = entity.weatherDescription ?? "Aucune description"
        self.windGust = entity.windGust
        self.windSpeed = entity.windSpeed
        self.cloudiness = Int(entity.cloudiness)
        self.pressure = Int(entity.pressure)
        self.humidity = Int(entity.humidity)
        self.oneHourRain = entity.oneHourRain
        self.oneHourSnow = entity.oneHourSnow
        self.sunset = Int(entity.sunset)
        self.sunrise = Int(entity.sunrise)
        self.weatherIcon = entity.weatherIcon ?? ""
        self.lastUpdateTime = Int(entity.lastUpdateTime)
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
}
