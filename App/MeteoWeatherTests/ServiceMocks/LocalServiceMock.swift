//
//  LocalServiceMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
import MeteoWeatherData

final class MeteoWeatherMockLocalService: MeteoWeatherLocalService {
    
    let forceFetchAllFailure: Bool
    
    init(forceFetchAllFailure: Bool) {
        self.forceFetchAllFailure = forceFetchAllFailure
    }
    
    func saveCityWeatherData(geocodedCity: MeteoWeatherData.GeocodedCity, currentWeather: MeteoWeatherData.CityCurrentWeather, completion: @escaping (Result<MeteoWeatherData.CityCurrentWeatherLocalEntity, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        // Simulate an error
        if geocodedCity.name != "Paris" {
            completion(.failure(.localDatabaseSavingError))
            
            return
        }
        
        // completion(.success(.dataMock()))
    }
    
    func fetchAllCities(completion: @escaping (Result<[MeteoWeatherData.CityCurrentWeatherLocalEntity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        // Simulate an error
        if forceFetchAllFailure {
            completion(.failure(.localDatabaseFetchError))
        } else {
            // completion(.success([.dataMock()]))
        }
    }
    
    func deleteCity(cityName: String, completion: @escaping (Result<Void, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        // Simulate an error
        if cityName != "Paris" {
            completion(.failure(.localDatabaseDeleteError))
            
            return
        }
        
        completion(.success(()))
    }
}
