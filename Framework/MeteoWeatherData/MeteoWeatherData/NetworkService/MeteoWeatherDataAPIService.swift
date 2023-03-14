//
//  MeteoWeatherDataAPIService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

/// The interface to use as abstraction for networking part, handling the API calls to OpenWeather API. Support with new Swift Concurrency (async / await) and classic one with completion handler.
public protocol MeteoWeatherDataAPIService {
    func fetchGeocodedCity(query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError>
    func fetchCurrentCityWeather(lat: Double, lon: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError>
    func fetchGeocodedCity(query: String, completion: @escaping (Result<[GeocodedCity], MeteoWeatherDataError>) -> ())
    func fetchCurrentCityWeather(lat: Double, lon: Double, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ())
}
