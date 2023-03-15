//
//  CityCurrentWeatherDataMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeather

extension CityCurrentWeatherOutput {
    static func mockData() -> [CityCurrentWeatherOutput] {
        let data = CityCurrentWeatherOutput(name: "Paris", country: "France", weatherIcon: "04d", weatherDescription: "Peu nuageux", temperature: 7.11, feelsLike: 5.35, tempMin: 6.28, tempMax: 7.71, lon: 2.3856, lat: 48.8543, sunset: 1678902855, sunrise: 1678860292, pressure: 1019, humidity: 79, cloudiness: 10000, windSpeed: 2.57, windGust: 8.94, oneHourRain: 10, oneHourSnow: 1, lastUpdateTime: 1678872960)
        
        return [data]
    }
}
