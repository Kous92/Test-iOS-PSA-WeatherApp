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
            
            init(cityWeather: CityCurrentWeather) {
                self.name = cityWeather.name
                self.country = cityWeather.country
                self.weatherIcon = cityWeather.weatherIcon
                self.weatherDescription = cityWeather.weatherDescription
                self.temperature = parseTemperature(with: cityWeather.temperature)
                self.sunset = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunset), option: .hourTime)
                self.sunrise = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunrise), option: .hourTime)
                self.pressure = "\(cityWeather.pressure) hPa"
                self.humidity = "\(cityWeather.humidity) %"
                self.cloudiness = "\(cityWeather.cloudiness) %"
                self.windSpeed = convertSpeed(speed: cityWeather.windSpeed)
                self.windGust = convertSpeed(speed: cityWeather.windGust)
                self.oneHourRain = "\(round(cityWeather.oneHourRain)) mm"
                self.threeHourRain = "\(round(cityWeather.threeHourRain)) mm"
                self.oneHourSnow = "\(round(cityWeather.oneHourSnow)) mm"
                self.threeHourSnow = "\(round(cityWeather.threeHourSnow)) mm"
            }
        }
    }
}
