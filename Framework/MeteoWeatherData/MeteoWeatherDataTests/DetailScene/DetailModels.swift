//
//  DetailModels.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

enum DetailEntity {
    enum WeatherDetails {
        struct Response {
            var cityWeather: CityCurrentWeather
        }
        
        struct ViewModel {
            let name: String
            let country: String
            let weatherIcon: String
            let weatherDescription: String
            let temperature: String
            let temperatureFeeling: String
            let minTemperature: String
            let maxTemperature: String
            let sunset: String
            let sunrise: String
            let pressure: String
            let humidity: String
            let cloudiness: String
            let windSpeed: String
            let windGust: String
            let oneHourRain: String
            let threeHourRain: String
            let oneHourSnow: String
            let threeHourSnow: String
            
            // Some data may not be available
            let temperatureAvailable: Bool
            let temperatureFeelingAvailable: Bool
            let minTemperatureAvailable: Bool
            let maxTemperatureAvailable: Bool
            let oneHourSnowAvailable: Bool
            let threeHourSnowAvailable: Bool
            let oneHourRainAvailable: Bool
            let threeHourRainAvailable: Bool
            let windSpeedAvailable: Bool
            let windGustAvailable: Bool
            
            // -999 are default values if data was not available from the network API for temperatures
            // -1 are default values if data was not available from the network API for others
            init(cityWeather: CityCurrentWeather) {
                self.name = cityWeather.name
                self.country = cityWeather.country
                self.weatherIcon = cityWeather.weatherIcon
                self.weatherDescription = cityWeather.weatherDescription.prefix(1).capitalized + cityWeather.weatherDescription.dropFirst().lowercased()
                self.temperature = cityWeather.temperature != -999 ? parseTemperature(with: cityWeather.temperature) : "??°C"
                self.temperatureAvailable = cityWeather.temperature != -999
                self.temperatureFeeling = cityWeather.feelsLike != -999 ? parseTemperature(with: cityWeather.feelsLike) : "??°C"
                self.temperatureFeelingAvailable = cityWeather.feelsLike != -999
                self.minTemperature = cityWeather.tempMin != -999 ? parseTemperature(with: cityWeather.tempMin) : "??°C"
                self.minTemperatureAvailable = cityWeather.tempMin != -999
                self.maxTemperature = cityWeather.tempMax != -999 ? parseTemperature(with: cityWeather.tempMax) : "??°C"
                self.maxTemperatureAvailable = cityWeather.tempMax != 999
                self.sunset = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunset), option: .hourTime)
                self.sunrise = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunrise), option: .hourTime)
                self.pressure = "\(cityWeather.pressure) hPa"
                self.humidity = "\(cityWeather.humidity) %"
                self.cloudiness = "\(cityWeather.cloudiness) %"
                self.windSpeed = cityWeather.windSpeed != 1 ? convertSpeed(speed: cityWeather.windSpeed) : "Aucune rafale de vent"
                self.windSpeedAvailable = cityWeather.windSpeed != 1
                self.windGust = convertSpeed(speed: cityWeather.windGust)
                self.windGustAvailable = cityWeather.windGust != 1
                self.oneHourRain = cityWeather.oneHourRain != -1 ? "\(round(cityWeather.oneHourRain)) mm" : "Aucune pluie"
                self.oneHourRainAvailable = cityWeather.oneHourRain != -1
                self.threeHourRain = cityWeather.threeHourRain != 1 ? "\(round(cityWeather.threeHourRain)) mm" : "Aucune pluie"
                self.threeHourRainAvailable = cityWeather.threeHourRain != 1
                self.oneHourSnow = cityWeather.oneHourSnow != 1 ? "\(round(cityWeather.oneHourSnow)) mm" : "Aucune chute de neige"
                self.oneHourSnowAvailable = cityWeather.oneHourSnow != 1
                self.threeHourSnow = cityWeather.threeHourSnow != 1 ? "\(round(cityWeather.threeHourSnow)) mm" : "Aucune chute de neige"
                self.threeHourSnowAvailable = cityWeather.threeHourSnow != 1
            }
        }
    }
}
