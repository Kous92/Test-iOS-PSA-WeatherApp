//
//  MeteoWeatherLocalService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

/// The interface to use as abstraction for local database part (for data persistence), to retrieve, update, save and delete data.
public protocol MeteoWeatherLocalService {
    /// Checks if an entity is already saved in the local database, to avoid any conflict during saving, updating or deleting operation.
    /// - Parameter name: The location of the weather entity, as filter (ex: Paris, Roma, London,...)
    /// - Returns: The entity if found, or `nil` if not
    func checkSavedCity(with name: String) -> CityCurrentWeatherEntity?
    
    /// Saves the downloaded data of the location into a local database.
    /// - Parameters:
    ///   - geocodedCity: The object of the retrieved city from OpenWeather Geocoding API
    ///   - currentWeather: The object of the retrieved city from OpenWeather Current weather data API
    ///   - completion: Closure to handle the result with saved entity if saving to the local database has succeeded, or an error if saving to the local database has failed.
    func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, completion: @escaping (Result<CityCurrentWeatherEntity, MeteoWeatherDataError>) -> ())
    
    /// Retrieves all locations current weather data saved in the local database
    /// - Parameter completion: Closure to handle the result with retrived saved entities if succeeded, or an error if failed.
    func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ())
    
    /// Delete a saved entity from the local database.
    /// - Parameters:
    ///   - city: The entity with full weather data to delete,
    ///   - completion: Closure to handle the result with if deletion has succeeded, or an error if failed.
    func deleteCity(city: CityCurrentWeatherEntity, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ())
}
