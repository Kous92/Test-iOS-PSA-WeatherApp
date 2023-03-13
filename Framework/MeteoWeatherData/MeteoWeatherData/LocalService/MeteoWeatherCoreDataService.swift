//
//  MeteoWeatherCoreDataService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation
import CoreData

public class MeteoWeatherCoreDataService: MeteoWeatherLocalService {
    public static let shared = MeteoWeatherCoreDataService()
    
    // Core Data requests
    let cityFetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
    
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
    
    // Returns localized city name if available or default name
    private func getCityName(with geocodedCity: GeocodedCity) -> String {
        return geocodedCity.localNames?["fr"] ?? geocodedCity.name
    }
    
    // Saving data from server to Core Data
    // -999 are default values if data was not available from the network API for temperatures
    // -1 are default values if data was not available from the network API for others
    public func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, completion: @escaping (Result<CityCurrentWeatherEntity, MeteoWeatherDataError>) -> ()) {
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
            cityCurrentWeatherEntity.threeHourRain = currentWeather.rain?.threeHour ?? -1
            cityCurrentWeatherEntity.oneHourSnow = currentWeather.snow?.oneHour ?? -1
            cityCurrentWeatherEntity.threeHourSnow = currentWeather.snow?.threeHour ?? -1
            cityCurrentWeatherEntity.sunset = Int64(currentWeather.sys?.sunset ?? -1)
            cityCurrentWeatherEntity.sunrise = Int64(currentWeather.sys?.sunrise ?? -1)
            cityCurrentWeatherEntity.weatherIcon = currentWeather.weather?[0].icon
            cityCurrentWeatherEntity.lastUpdateTime = Int64(currentWeather.dt ?? -1)
            
            self.saveData(operationDescription: "Sauvegarde de la météo de la ville de \(geocodedCity.name)", context: context) { result in
                switch result {
                    case .success():
                        print(cityCurrentWeatherEntity)
                        completion(.success(cityCurrentWeatherEntity))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
    
    // All transactions must be saved from the context (deletion, addition, update)
    private func saveData(operationDescription: String, context: NSManagedObjectContext, completion: (Result<Void, MeteoWeatherDataError>) -> ()) {
        // Save Data
        do {
            try context.save()
            print("[MeteoWeatherCoreDataService] ✅ \(operationDescription): succès")
            completion(.success(()))
        } catch {
            print("[MeteoWeatherCoreDataService] ❌ \(operationDescription): échec.\n\(error)")
            completion(.failure(.localDatabaseSavingError))
        }
    }

    public func checkSavedCity(with name: String) -> CityCurrentWeatherEntity? {
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
    
    public func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ()) {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo. Contexte indisponible.")
            completion(.failure(.localDatabaseError))
            return
        }
        
        let fetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
        
        do {
            let cities = try context.fetch(fetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
            completion(.success(cities))
        } catch let fetchError {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
            completion(.failure(.localDatabaseFetchError))
        }
    }
    
    // Main thread
    public func deleteCity(city: CityCurrentWeatherEntity, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ()) {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération du contexte.")
            completion(.failure(.localDatabaseFetchError))
            return
        }
        
        print("[MeteoWeatherCoreDataService] Suppression de \(city.name ?? "??")...")
        context.delete(city)
        saveData(operationDescription: "Suppression de \(city.name ?? "??")", context: context, completion: completion)
    }
}
