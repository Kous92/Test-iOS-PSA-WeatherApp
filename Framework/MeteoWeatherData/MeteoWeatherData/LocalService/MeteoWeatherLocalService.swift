//
//  MeteoWeatherLocalService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

public protocol MeteoWeatherLocalService {
    func checkSavedCity(with name: String) -> CityCurrentWeatherEntity?
    func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, completion: @escaping (Result<CityCurrentWeatherEntity, MeteoWeatherDataError>) -> ())
    func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ())
    func deleteCity(city: CityCurrentWeatherEntity, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ())
}
