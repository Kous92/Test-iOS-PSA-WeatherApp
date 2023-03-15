//
//  CityCurrentWeatherEntityMock.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
import CoreData
@testable import MeteoWeatherData

extension CityCurrentWeatherLocalEntity {
    static func dataMock() -> CityCurrentWeatherLocalEntity {
        // An NSManagedObject of class 'CityCurrentWeatherEntity' must have a valid NSEntityDescription. (NSInvalidArgumentException)
        let entity = CityCurrentWeatherLocalEntity(
            name: "Paris", country: "France", weatherIcon: "04d", weatherDescription: "Peu nuageux", temperature: 7, feelsLike: 5, tempMin: 6, tempMax: 7, lon: 48.8543, lat: 2.3856, sunset: 1678902855, sunrise: 1678860292, pressure: 1019, humidity: 81, cloudiness: 1000, windSpeed: 2.57, windGust: 8.94, oneHourRain: 10, oneHourSnow: 1, lastUpdateTime: 1678872960)
        
        return entity
    }
}
