//
//  MeteoWeatherLocalService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

public protocol MeteoWeatherLocalService {
    func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather)
    func checkSavedCities() async -> Int
    func fetchCity(name: String) -> CityCurrentWeatherEntity
    func fetchAllCities() -> [CityCurrentWeatherEntity]
    func asyncFetchAllCities() async -> [CityCurrentWeatherEntity]
    func deleteCity(city: CityCurrentWeatherEntity)
    func deleteAllCities() async
}
