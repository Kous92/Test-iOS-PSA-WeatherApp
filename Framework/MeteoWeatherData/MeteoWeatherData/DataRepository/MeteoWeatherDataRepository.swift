//
//  MeteoWeatherDataRepository.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

public class MeteoWeatherDataRepository {
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
    
    // Returns localized city name if available or default name
    private func getCityName(with geocodedCity: GeocodedCity) -> String {
        return geocodedCity.localNames?["fr"] ?? geocodedCity.name
    }
    
    public func addCity(with geocodedCity: GeocodedCity, completion: @escaping (Result<CityCurrentWeatherEntity, MeteoWeatherDataError>) -> ()) {
        if let existingCity = localService?.checkSavedCity(with: getCityName(with: geocodedCity)) {
            print("Attention: conflit avec la ville de \(existingCity.name ?? "??")")
            
            localService?.deleteCity(city: existingCity) { result in
                if case .failure(let error) = result {
                    print("Attention: la ville déjà existante n'a pas pu être supprimée \(existingCity.name ?? "??")")
                    completion(.failure(error))
                    
                    return
                }
                
                print("Mise à jour des données météo de la ville de \(existingCity.name ?? "??")")
            }
        }
        
        print("-> 2.1: Téléchargement des nouvelles données de \(geocodedCity.name)...")
        networkService?.fetchCurrentCityWeather(lat: geocodedCity.lat, lon: geocodedCity.lon, completion: { [weak self] result in
            switch result {
                case .success(let currentWeather):
                    print("-> 2.2: Sauvegarde locale des nouvelles données de \(geocodedCity.name)...")
                    self?.localService?.saveCityWeatherData(geocodedCity: geocodedCity, currentWeather: currentWeather, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
    
    // Fetches all cities with their respective data, saved locally
    public func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ()) {
        localService?.fetchAllCities(completion: completion)
    }
    
    // Delete a city, saved locally
    public func deleteCity(with name: String, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Retrieve the existing entity
        if let cityToDelete = localService?.checkSavedCity(with: name) {
            print("La ville de \(name) sera supprimée")
           localService?.deleteCity(city: cityToDelete) { result in
                completion(result)
            }
        }
    }
}
