//
//  MeteoWeatherDataAPIService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

/// The interface to use as abstraction for networking part, handling the API calls to OpenWeather API. Support with new Swift Concurrency (`async` / `await) and classic one with completion handler.
public protocol MeteoWeatherDataAPIService {
    /// Retrieves the geocoded city with name, country and GPS position. This method supports Swift Concurrency to be used in an `async` task (`Task`).
    /// - Parameter query: the name of location to search
    /// - Returns: The result of the fetch operation. An object of the retrieved geocoded city from OpenWeatherAPI Geocoding API if it has succeeded, an error if it fails.
    func fetchGeocodedCity(query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError>
    
    /// Retrieves the full current weather of a city. This method supports Swift Concurrency to be used in an `async` task (`Task`).
    /// - Parameters:
    ///   - lat: Geographical coordinates of the found location (latitude)
    ///   - lon: Geographical coordinates of the found location (longitude)
    /// - Returns: The result of the fetch operation. An object of the retrieved city current weather from OpenWeatherAPI Geocoding API if it has succeeded, an error if it fails.
    func fetchCurrentCityWeather(lat: Double, lon: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError>
    
    /// Retrieves the geocoded city with name, country and GPS position.
    /// - Parameter query: the name of location to search
    /// - Parameter completion: Closure to handle the result with the decoded object of the retrieved geocoded city from OpenWeather Geocoding data API if operation has succeeded, or an error if the operation have failed.
    func fetchGeocodedCity(query: String, completion: @escaping (Result<[GeocodedCity], MeteoWeatherDataError>) -> ())
    
    
    /// Retrieves the full current weather of a city.
    /// - Parameters:
    ///   - lat: Geographical coordinates of the found location (latitude)
    ///   - lon: Geographical coordinates of the found location (longitude)
    /// - Returns: The result of the fetch operation. An object of the retrieved city current weather from OpenWeather Current weather data API if it has succeeded, an error if it fails.
    func fetchCurrentCityWeather(lat: Double, lon: Double, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ())
}
