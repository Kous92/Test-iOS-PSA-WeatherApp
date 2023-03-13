//
//  MeteoWeatherDataRepository.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 11/03/2023.
//

import Foundation

public class MeteoWeatherDataRepository {
    private let networkService: MeteoWeatherDataAPIService?
    // private let localService: MeteoWeatherLocalService?
    
    // Dependency injection, ready for testing.
    public init(networkService: MeteoWeatherDataAPIService?) {
        self.networkService = networkService
        // self.localService = localService
    }
    
    public func searchCity(with query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError> {
        guard let networkService else {
            return .failure(.apiError)
        }
        
        return await networkService.fetchGeocodedCity(query: query)
    }
    
    public func searchCity(with query: String, completion: @escaping (Result<[GeocodedCity], MeteoWeatherDataError>) -> ()) {
        networkService?.fetchGeocodedCity(query: query, completion: completion)
    }
    
    // Returns localized city name if available or default name
    private func getCityName(with geocodedCity: GeocodedCity) -> String {
        return geocodedCity.localNames?["fr"] ?? geocodedCity.name
    }
    
    public func addCity(with geocodedCity: GeocodedCity, completion: @escaping (Result<CityCurrentWeatherEntity, MeteoWeatherDataError>) -> ()) {
        if let existingCity = MeteoWeatherCoreDataService.shared.checkSavedCity(with: getCityName(with: geocodedCity)) {
            print("Attention: conflit avec la ville de \(existingCity.name ?? "??")")
            
            MeteoWeatherCoreDataService.shared.deleteCity(city: existingCity) { result in
                if case .failure(let error) = result {
                    print("Attention: la ville déjà existante n'a pas pu être supprimée \(existingCity.name ?? "??")")
                    completion(.failure(error))
                    
                    return
                }
                
                print("Mise à jour des données météo de la ville de \(existingCity.name ?? "??")")
            }
        }
        
        print("-> 2.1: Téléchargement des nouvelles données de \(geocodedCity.name)...")
        networkService?.fetchCurrentCityWeather(lat: geocodedCity.lat, lon: geocodedCity.lon, completion: { result in
            switch result {
                case .success(let currentWeather):
                    print("-> 2.2: Sauvegarde locale des nouvelles données de \(geocodedCity.name)...")
                    MeteoWeatherCoreDataService.shared.saveCityWeatherData(geocodedCity: geocodedCity, currentWeather: currentWeather) { city in
                        completion(.success(city))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
    
    // Fetches all cities with their respective data, saved locally
    public func fetchAllCities() -> [CityCurrentWeatherEntity] {
        return MeteoWeatherCoreDataService.shared.fetchAllCities()
    }
    
    // Fetches all cities with their respective data, saved locally
    public func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ()) {
        MeteoWeatherCoreDataService.shared.fetchAllCities(completion: completion)
    }
    
    public func deleteCity(with name: String, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Retrieve the existing entity
        if let cityToDelete = MeteoWeatherCoreDataService.shared.checkSavedCity(with: name) {
            print("La ville de \(name) sera supprimée")
            MeteoWeatherCoreDataService.shared.deleteCity(city: cityToDelete) { result in
                completion(result)
            }
        }
    }

    public func updateCities(completion: @escaping (Result<Bool, MeteoWeatherDataError>) -> ()) {
        let savedCities = MeteoWeatherCoreDataService.shared.fetchAllCities().compactMap { GeocodedCity(name: $0.name ?? "", localNames: nil, lat: $0.lat, lon: $0.lon, country: $0.country ?? "", state: nil) }
        
        guard savedCities.count > 0 else {
            print("Aucune donnée disponible")
            completion(.failure(.localDatabaseError))
            return
        }
        
        print("Mise à jour des données météorologique de \(savedCities.count) villes")
        print("Étape 1, suppression des anciennes données...")
        
        MeteoWeatherCoreDataService.shared.deleteAllCities()
        
        print("Étape 2: Téléchargement des nouvelles données...")
        var cities = [CityCurrentWeather]()
        let group = DispatchGroup()
        
        for city in savedCities {
            group.enter()
            
            print("-> 2.1: Téléchargement des nouvelles données de \(city.name)...")

            networkService?.fetchCurrentCityWeather(lat: city.lat, lon: city.lon) { result in
                switch result {
                    case .success(let currentWeather):
                        cities.append(currentWeather)
                        group.leave()
                    case .failure(let error):
                        completion(.failure(error))
                        return
                }
            }
        }
        
        group.notify(queue: .main) {
            print("-> 2.2: Sauvegarde locale des nouvelles données de \(cities) villes...")
            MeteoWeatherCoreDataService.shared.updateCitiesWeatherData(geocodedCities: savedCities, currentWeather: cities)
            completion(.success(true))
        }
        
        /*
        for city in savedCities {
            print("-> 2.1: Téléchargement des nouvelles données de \(city.name)...")
            group.enter()
            let weatherResult = await networkService.fetchCurrentCityWeather(lat: city.lat, lon: city.lon)
            
            switch weatherResult {
                case .success(let currentWeather):
                    print("-> 2.2: Sauvegarde locale des nouvelles données de \(city.name)...")
                    await localService.saveCityWeatherData(geocodedCity: city, currentWeather: currentWeather)
                    
                    return .success(await localService.asyncFetchAllCities())
                case .failure(let error):
                    return .failure(error)
            }
        }
         */
    }
}
