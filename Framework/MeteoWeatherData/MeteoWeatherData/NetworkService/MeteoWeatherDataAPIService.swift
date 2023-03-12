//
//  MeteoWeatherDataAPIService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public protocol MeteoWeatherDataAPIService {
    func fetchGeocodedCity(query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError>
    func fetchCurrentCityWeather(lat: Double, lon: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError>
    
    func fetchGeocodedCity(query: String, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ())
    func fetchCurrentCityWeather(lat: Double, lon: Double, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ())
}
