//
//  MeteoWeatherDataRepository.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

/// The link between app layer and data layer of MeteoWeather app Clean Architecture. This class follows the Repository design pattern to provide an abstraction of data part, as interface to retrieve, save and delete data.
public class MeteoWeatherDataRepository: MeteoWeatherDataRepositoryProtocol {
    private let networkService: MeteoWeatherDataAPIService?
    private let localService: MeteoWeatherLocalService?
    
    // Dependency injection, ready for testing.
    public init(networkService: MeteoWeatherDataAPIService?, localService: MeteoWeatherLocalService?) {
        self.networkService = networkService
        self.localService = localService
    }
    
    public func searchCity(with query: String, completion: @escaping (Result<[GeocodedCity], MeteoWeatherDataError>) -> ()) {
        networkService?.fetchGeocodedCity(query: query, completion: completion)
    }
    
    /// Returns localized city name if available or default name
    /// - Parameter geocodedCity: The object of the retrieved city from OpenWeatherAPI Geocoding API
    /// - Returns: The name of city translated in french or the default one retreived from OpenWeatherAPI
    private func getCityName(with geocodedCity: GeocodedCity) -> String {
        return geocodedCity.localNames?["fr"] ?? geocodedCity.name
    }
    
    
    /// From geocoded city object previously retrieved, it downloads and saves data with OpenWeatherAPI Current weather data.
    /// - Parameters:
    ///   - geocodedCity: The object of the retrieved city from OpenWeatherAPI Geocoding API
    ///   - completion: Closure to handle the result with saved entity if saving to the local database has succeeded, or an error if saving to the local database has failed.
    public func addCity(with geocodedCity: GeocodedCity, completion: @escaping (Result<CityCurrentWeatherLocalEntity, MeteoWeatherDataError>) -> ()) {
        let cityName = getCityName(with: geocodedCity)
        
        // Deletion succeeded: update of data, failed: creation of data
        localService?.deleteCity(cityName: getCityName(with: geocodedCity)) { [weak self] result in
            if case .failure(_) = result {
                print("La ville de \(cityName) n'existe pas")
            } else {
                print("Mise à jour des données météo de la ville de \(cityName)")
            }
            
            print("-> 2.1: Téléchargement des nouvelles données de \(geocodedCity.name)...")
            self?.networkService?.fetchCurrentCityWeather(lat: geocodedCity.lat, lon: geocodedCity.lon, completion: { [weak self] result in
                switch result {
                    case .success(let currentWeather):
                        print("-> 2.2: Sauvegarde locale des nouvelles données de \(geocodedCity.name)...")
                        self?.localService?.saveCityWeatherData(geocodedCity: geocodedCity, currentWeather: currentWeather, completion: completion)
                    case .failure(let error):
                        completion(.failure(error))
                }
            })
        }
    }
    
    // Fetches all cities with their respective data, saved locally
    public func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherLocalEntity], MeteoWeatherDataError>) -> ()) {
        localService?.fetchAllCities(completion: completion)
    }
    
    // Delete a city, saved locally
    public func deleteCity(with name: String, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Retrieve the existing entity
        localService?.deleteCity(cityName: name) { result in
            completion(result)
        }
    }
}
