//
//  MeteoWeatherCoreDataService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation
import CoreData

/// This class manages the Core Data local database service for data persistence, for retrieving, saving, updating and deleting data.
public class MeteoWeatherCoreDataService: MeteoWeatherLocalService {
    /// The shared singleton object
    public static let shared = MeteoWeatherCoreDataService()
    
    /// Core Data request to fetch location current weather data
    let cityFetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
    
    /// A container that encapsulates the Core Data stack. With a custom configuration to handle different operations.
    private lazy var persistentContainer: NSPersistentContainer? = {
        // Framework bundle ID and Core Data model name are needed to use a persistent container in a framework.
        let identifier: String = "com.kous92.MeteoWeatherData"
        let model: String = "MeteoWeatherCoreDataModel"
        
        guard let bundle = Bundle(identifier: identifier),
              let modelURL = bundle.url(forResource: model, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("Création impossible du conteneur de persistance")
        }
        
        let container = NSPersistentContainer(name: model, managedObjectModel: managedObjectModel)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("[MeteoWeatherCoreDataService] ❌ Échec du chargement du conteneur de persistance: \(error)")
            }
            
            print(storeDescription)
            print("[MeteoWeatherCoreDataService] ✅ Chargement du conteneur de persistance réussi.")
            
            // Prevent duplicates. Also, a constraint is added on CityCurrentWeatherEntity, the name property.
            // Make sure that the database does not already contains several entities with same name, otherwise it won't load the persistent store.
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
        
        return container
    }()
    
    /// Returns localized city name if available or default name
    /// - Parameter geocodedCity: The object of the retrieved city from OpenWeather Geocoding API
    /// - Returns: Localized city name if available or default name
    private func getCityName(with geocodedCity: GeocodedCity) -> String {
        return geocodedCity.localNames?["fr"] ?? geocodedCity.name
    }
    
    /// Saves the downloaded data of the location into Core Data database. This operation is executed on the background thread.
    /// - Parameters:
    ///   - geocodedCity: The object of the retrieved city from OpenWeather Geocoding API
    ///   - currentWeather: The object of the retrieved city from OpenWeather Current weather data API
    ///   - completion: Closure to handle the result with saved entity if saving to the local database has succeeded, or an error if saving to the local database has failed.
    ///
    /// `-999` are default values if data was not available from the network API for temperatures.
    /// `-1` are default values if data was not available from the network API for others.
    public func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, completion: @escaping (Result<CityCurrentWeatherLocalEntity, MeteoWeatherDataError>) -> ()) {
        self.persistentContainer?.performBackgroundTask { (context) in
            context.automaticallyMergesChangesFromParent = true
            
            let cityCurrentWeatherEntity = CityCurrentWeatherEntity(context: context)
            cityCurrentWeatherEntity.country = geocodedCity.country
            cityCurrentWeatherEntity.name = self.getCityName(with: geocodedCity)
            cityCurrentWeatherEntity.lat = geocodedCity.lat
            cityCurrentWeatherEntity.lon = geocodedCity.lon
            cityCurrentWeatherEntity.temperature = currentWeather.main?.temp ?? -999
            cityCurrentWeatherEntity.feelsLike = currentWeather.main?.feelsLike ?? -999
            cityCurrentWeatherEntity.tempMin = currentWeather.main?.tempMin ?? -999
            cityCurrentWeatherEntity.tempMax = currentWeather.main?.tempMax ?? -999
            cityCurrentWeatherEntity.weatherDescription = currentWeather.weather?[0].description
            cityCurrentWeatherEntity.windGust = currentWeather.wind?.gust ?? -1
            cityCurrentWeatherEntity.windSpeed = currentWeather.wind?.speed ?? -1
            cityCurrentWeatherEntity.cloudiness = Int64(currentWeather.clouds?.all ?? 0)
            cityCurrentWeatherEntity.pressure = Int64(currentWeather.main?.pressure ?? -1)
            cityCurrentWeatherEntity.humidity = Int64(currentWeather.main?.humidity ?? 0)
            cityCurrentWeatherEntity.oneHourRain = currentWeather.rain?.oneHour ?? -1
            cityCurrentWeatherEntity.oneHourSnow = currentWeather.snow?.oneHour ?? -1
            cityCurrentWeatherEntity.sunset = Int64(currentWeather.sys?.sunset ?? -1)
            cityCurrentWeatherEntity.sunrise = Int64(currentWeather.sys?.sunrise ?? -1)
            cityCurrentWeatherEntity.weatherIcon = currentWeather.weather?[0].icon
            cityCurrentWeatherEntity.lastUpdateTime = Int64(currentWeather.dt ?? -1)
            
            let localEntity = CityCurrentWeatherLocalEntity(with: geocodedCity, currentWeather: currentWeather)
            
            self.saveData(operationDescription: "Sauvegarde de la météo de la ville de \(geocodedCity.name)", context: context) { result in
                switch result {
                    case .success():
                        print(cityCurrentWeatherEntity)
                        print(localEntity)
                        completion(.success(localEntity))
                    case .failure(let error):
                        print("[ATTENTION] \(error.rawValue)")
                        completion(.failure(error))
                }
            }
        }
    }
    
    /// It saves all changes from deletion, addition, update operation, from the Core Data persistent container context. This operation can be executed on the main or background thread.
    /// - Parameters:
    ///   - operationDescription: For debugging, to describe which operation is processing
    ///   - context: An object space to manipulate and track changes to managed objects. On main thread or backround thread.
    ///   - completion: Closure to handle if saving operation in the context has succeeded, or an error if failed.
    private func saveData(operationDescription: String, context: NSManagedObjectContext, completion: (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Save Data
        do {
            try context.save()
            print("[MeteoWeatherCoreDataService] ✅ \(operationDescription): succès")
            completion(.success(()))
        } catch {
            print("[MeteoWeatherCoreDataService] ❌ \(operationDescription): échec.\n\(error)")
            print("[ATTENTION] \(MeteoWeatherDataError.localDatabaseSavingError.rawValue)")
            completion(.failure(.localDatabaseSavingError))
        }
    }
    
    /*
    /// Checks if an entity is already saved in the Core Data local database, to avoid any conflict during saving, updating or deleting operation.
    /// - Parameter name: The location of the weather entity, as filter (ex: Paris, Roma, London,...)
    /// - Returns: The entity if found, or `nil` if not
    public func checkSavedCity(with name: String) -> CityCurrentWeatherLocalEntity? {
        let filterPredicate = NSPredicate(format: "name LIKE[c] %@", name)
        cityFetchRequest.predicate = filterPredicate
        cityFetchRequest.fetchLimit = 1
        
        print("[MeteoWeatherCoreDataService] ✅ Vérification de l'existence de \(name).")
        
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌Contexte indisponible.")
            fatalError("[MeteoWeatherCoreDataService] ❌ Contexte indisponible.")
        }
        
        do {
            let output = try context.fetch(cityFetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Terminé. \(name) \(output.count > 0 ? "existe" : "n'existe pas")")
            
            return output.count > 0 ? CityCurrentWeatherLocalEntity(entity: output[0]) : nil
        } catch {
            fatalError("[MeteoWeatherCoreDataService] ❌ Erreur: \(error)")
        }
    }
     */
    
    /// Checks if an entity is already saved in the Core Data local database, to avoid any conflict during saving, updating or deleting operation.
    /// - Parameter name: The location of the weather entity, as filter (ex: Paris, Roma, London,...)
    /// - Returns: The entity if found, or `nil` if not
    private func checkSavedCity(with name: String) -> CityCurrentWeatherEntity? {
        let filterPredicate = NSPredicate(format: "name LIKE[c] %@", name)
        cityFetchRequest.predicate = filterPredicate
        cityFetchRequest.fetchLimit = 1
        
        print("[MeteoWeatherCoreDataService] ✅ Vérification de l'existence de \(name).")
        
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌Contexte indisponible.")
            fatalError("[MeteoWeatherCoreDataService] ❌ Contexte indisponible.")
        }
        
        do {
            let output = try context.fetch(cityFetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Terminé. \(name) \(output.count > 0 ? "existe" : "n'existe pas")")
            
            return output.count > 0 ? output[0] : nil
        } catch {
            fatalError("[MeteoWeatherCoreDataService] ❌ Erreur: \(error)")
        }
    }
    
    /// Retrieves all locations current weather data saved in the Core Data local database
    /// - Parameter completion: Closure to handle the result with retrived saved entities if succeeded, or an error if failed.
    public func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherLocalEntity], MeteoWeatherDataError>) -> ()) {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo. Contexte indisponible.")
            completion(.failure(.localDatabaseError))
            return
        }
        
        let fetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
        
        do {
            let cities = try context.fetch(fetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
            
            let localCities = cities.map { CityCurrentWeatherLocalEntity(entity: $0) }
            completion(.success(localCities))
        } catch let fetchError {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
            completion(.failure(.localDatabaseFetchError))
        }
    }
    
    /// Delete a saved entity from the Core Data local database. This operation is executed on the main thread.
    /// - Parameters:
    ///   - city: The entity with full weather data to delete,
    ///   - completion: Closure to handle the result with if deletion has succeeded, or an error if failed.
    public func deleteCity(cityName: String, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Retrieve the existing entity
        guard let cityToDelete = checkSavedCity(with: cityName) else {
            print("La ville de \(cityName) n'existe pas dans la base de données")
            completion(.failure(.localDatabaseDeleteError))
            return
        }
        
        print("La ville de \(cityToDelete.name ?? "??") sera supprimée")
        
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération du contexte.")
            completion(.failure(.localDatabaseFetchError))
            return
        }
        
        print("[MeteoWeatherCoreDataService] Suppression de \(cityToDelete.name ?? "??")...")
        context.delete(cityToDelete)
        saveData(operationDescription: "Suppression de \(cityToDelete.name ?? "??")", context: context, completion: completion)
    }
    
    /*
    public func deleteCity(city: CityCurrentWeatherLocalEntity, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Retrieve the existing entity
        guard let cityToDelete = checkSavedCity(with: city.name) else {
            print("La ville de \(city.name) n'existe pas dans la base de données")
            completion(.failure(.localDatabaseDeleteError))
            return
        }
        
        print("La ville de \(cityToDelete.name ?? "??") sera supprimée")
        
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération du contexte.")
            completion(.failure(.localDatabaseFetchError))
            return
        }
        
        print("[MeteoWeatherCoreDataService] Suppression de \(cityToDelete.name ?? "??")...")
        context.delete(cityToDelete)
        saveData(operationDescription: "Suppression de \(cityToDelete.name ?? "??")", context: context, completion: completion)
    }
     */
}
