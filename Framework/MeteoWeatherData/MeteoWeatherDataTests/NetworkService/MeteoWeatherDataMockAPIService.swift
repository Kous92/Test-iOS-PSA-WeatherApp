//
//  MeteoWeatherDataMockAPIService.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeatherData

final class MeteoWeatherDataMockAPIService: MeteoWeatherDataAPIService {
    
    let forceFetchAllFailure: Bool
    
    init(forceFetchAllFailure: Bool) {
        self.forceFetchAllFailure = forceFetchAllFailure
    }
    
    func fetchGeocodedCity(query: String) async -> Result<[MeteoWeatherData.GeocodedCity], MeteoWeatherData.MeteoWeatherDataError> {
        // Simulate failure
        if query == "Paris" {
            return .success([.dataMock()])
        } else {
            return .failure(.apiError)
        }
    }
    
    func fetchCurrentCityWeather(lat: Double, lon: Double) async -> Result<MeteoWeatherData.CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError> {
        // Simulate failure
        if lat == 48.8646 && lon == 2.3343 {
            return .success(.dataMock())
        } else {
            return .failure(.apiError)
        }
    }
    
    func fetchGeocodedCity(query: String, completion: @escaping (Result<[MeteoWeatherData.GeocodedCity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        // Simulate failure
        if query == "Paris" {
            completion(.success([.dataMock()]))
        } else {
            completion(.failure(.apiError))
        }
    }
    
    func fetchCurrentCityWeather(lat: Double, lon: Double, completion: @escaping (Result<MeteoWeatherData.CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        // Simulate failure
        if lat == 48.8646 && lon == 2.3343 {
            completion(.success(.dataMock()))
        } else {
            completion(.failure(.apiError))
        }
    }
}
