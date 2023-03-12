//
//  MeteoWeatherCoreDataService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation
import CoreData

public class MeteoWeatherCoreDataService {
    public func fetchCity(name: String) -> CityCurrentWeatherEntity {
        return CityCurrentWeatherEntity()
    }
    
    public static let shared = MeteoWeatherCoreDataService()
    
    public init() {
        
    }
    
    // Core Data requests
    let cityFetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
    let deleteAllCitiesRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "CityCurrentWeatherEntity"))
    
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
    public func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather) {
        self.persistentContainer?.performBackgroundTask { (context) in
            let cityCurrentWeatherEntity = CityCurrentWeatherEntity(context: context)
            cityCurrentWeatherEntity.country = geocodedCity.country
            cityCurrentWeatherEntity.name = self.getCityName(with: geocodedCity)
            cityCurrentWeatherEntity.lat = geocodedCity.lat
            cityCurrentWeatherEntity.lon = geocodedCity.lon
            cityCurrentWeatherEntity.temperature = currentWeather.main?.temp ?? 0
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
            
            self.saveData(operationDescription: "Sauvegarde de la météo de la ville de \(geocodedCity.name)", context: context)
            
            print(cityCurrentWeatherEntity)
        }
    }
    
    private func updateCityWeatherData(with entity: CityCurrentWeatherEntity, geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, context: NSManagedObjectContext) {
        entity.country = geocodedCity.country
        entity.name = self.getCityName(with: geocodedCity)
        entity.lat = geocodedCity.lat
        entity.lon = geocodedCity.lon
        entity.temperature = currentWeather.main?.temp ?? 0
        entity.weatherDescription = currentWeather.weather?[0].description
        entity.windGust = currentWeather.wind?.gust ?? -1
        entity.windSpeed = currentWeather.wind?.speed ?? -1
        entity.cloudiness = Int64(currentWeather.clouds?.all ?? 0)
        entity.pressure = Int64(currentWeather.main?.pressure ?? -1)
        entity.humidity = Int64(currentWeather.main?.humidity ?? 0)
        entity.oneHourRain = currentWeather.rain?.oneHour ?? -1
        entity.threeHourRain = currentWeather.rain?.threeHour ?? -1
        entity.oneHourSnow = currentWeather.snow?.oneHour ?? -1
        entity.threeHourSnow = currentWeather.snow?.threeHour ?? -1
        entity.sunset = Int64(currentWeather.sys?.sunset ?? -1)
        entity.sunrise = Int64(currentWeather.sys?.sunrise ?? -1)
        entity.weatherIcon = currentWeather.weather?[0].icon
        
        self.saveData(operationDescription: "Mise à jour de la météo de la ville de \(geocodedCity.name)", context: context)
        
        print(entity)
    }
    
    // Saving data from server to Core Data
    public func saveCityWeatherData(geocodedCity: GeocodedCity, currentWeather: CityCurrentWeather, completion: @escaping (CityCurrentWeatherEntity) -> ()) {
        self.persistentContainer?.performBackgroundTask { (context) in
            context.automaticallyMergesChangesFromParent = true
            
            let cityCurrentWeatherEntity = CityCurrentWeatherEntity(context: context)
            cityCurrentWeatherEntity.country = geocodedCity.country
            cityCurrentWeatherEntity.name = self.getCityName(with: geocodedCity)
            cityCurrentWeatherEntity.lat = geocodedCity.lat
            cityCurrentWeatherEntity.lon = geocodedCity.lon
            cityCurrentWeatherEntity.temperature = currentWeather.main?.temp ?? -999
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
            
            self.saveData(operationDescription: "Sauvegarde de la météo de la ville de \(geocodedCity.name)", context: context)
            
            print(cityCurrentWeatherEntity)
            completion(cityCurrentWeatherEntity)
        }
    }
    
    public func updateCitiesWeatherData(geocodedCities: [GeocodedCity], currentWeather: [CityCurrentWeather]) {
        self.persistentContainer?.performBackgroundTask { context in
            for (position, weather) in zip(geocodedCities, currentWeather) {
                let cityCurrentWeatherEntity = CityCurrentWeatherEntity(context: context)
                cityCurrentWeatherEntity.country = position.country
                cityCurrentWeatherEntity.name = self.getCityName(with: position)
                cityCurrentWeatherEntity.lat = position.lat
                cityCurrentWeatherEntity.lon = position.lon
                cityCurrentWeatherEntity.temperature = weather.main?.temp ?? -999
                cityCurrentWeatherEntity.weatherDescription = weather.weather?[0].description
                cityCurrentWeatherEntity.windGust = weather.wind?.gust ?? -1
                cityCurrentWeatherEntity.windSpeed = weather.wind?.speed ?? -1
                cityCurrentWeatherEntity.cloudiness = Int64(weather.clouds?.all ?? 0)
                cityCurrentWeatherEntity.pressure = Int64(weather.main?.pressure ?? -1)
                cityCurrentWeatherEntity.humidity = Int64(weather.main?.humidity ?? 0)
                cityCurrentWeatherEntity.oneHourRain = weather.rain?.oneHour ?? -1
                cityCurrentWeatherEntity.threeHourRain = weather.rain?.threeHour ?? -1
                cityCurrentWeatherEntity.oneHourSnow = weather.snow?.oneHour ?? -1
                cityCurrentWeatherEntity.threeHourSnow = weather.snow?.threeHour ?? -1
                cityCurrentWeatherEntity.sunset = Int64(weather.sys?.sunset ?? -1)
                cityCurrentWeatherEntity.sunrise = Int64(weather.sys?.sunrise ?? -1)
                cityCurrentWeatherEntity.weatherIcon = weather.weather?[0].icon
            }
            
            self.saveData(operationDescription: "Sauvegarde des données de météo de \(geocodedCities.count) villes...", context: context)
        }
    }

    // To avoid race conditions
    private func retrieveCityWeatherAfterSaving(name: String, backgroundContext: NSManagedObjectContext) -> CityCurrentWeatherEntity {
        print("[MeteoWeatherCoreDataService] Chargement de la météo de \(name)...")
        
        let filterPredicate = NSPredicate(format: "name LIKE[c] %@", name)
        cityFetchRequest.predicate = filterPredicate
        cityFetchRequest.fetchLimit = 1
        
        do {
            let cities = try backgroundContext.fetch(self.cityFetchRequest).first
            print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
            return cities!
        } catch let fetchError {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
            fatalError("Erreur lors de la récupération des données de météo: \(fetchError)")
        }
    }
    
    public func fetchCityWeather() {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌Contexte indisponible.")
            
            return
        }
        
        let fetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
        
        do {
            let cityWeather = try context.fetch(fetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Chargement de la météo de \(cityWeather.compactMap { $0.name }) terminée.")
            print(cityWeather.compactMap { city in
                return "\(city.name ?? "??"): \(city.temperature)°C"
            })
            
        } catch let fetchError {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo. \(fetchError)")
        }
    }
    
    private func saveData(operationDescription: String, context: NSManagedObjectContext) {
        // Save Data
        do {
            try context.save()
            print("[MeteoWeatherCoreDataService] ✅ \(operationDescription): succès")
        } catch {
            print("[MeteoWeatherCoreDataService] ❌ \(operationDescription): échec.\n\(error)")
        }
    }
    
    public func checkSavedCities() -> Int {
        var count = 0

        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌Contexte indisponible.")
            return count
        }
        
        do {
            count = try context.count(for: self.cityFetchRequest)
            print("[MeteoWeatherCoreDataService] \(count > 0 ? "✅" : "❌") Villes sauvegardées: \(count)")
        } catch {
            fatalError("Erreur comptage: \(error)")
        }
        
        return count
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
    
    /*
    public func fetchCity(name: String) async -> CityCurrentWeatherEntity {
        print("[MeteoWeatherCoreDataService] Chargement de la météo de \(name)...")
        
        let filterPredicate = NSPredicate(format: "name LIKE[c] %@", name)
        cityFetchRequest.predicate = filterPredicate
        cityFetchRequest.fetchLimit = 1
        
        let context = persistentContainer?.newBackgroundContext()
        context?.automaticallyMergesChangesFromParent = true
        
        return await context?.perform {
            do {
                let cities = try context?.fetch(self.cityFetchRequest).first
                print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
                return cities
            } catch let fetchError {
                print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
                fatalError("Erreur lors de la récupération des données de météo: \(fetchError)")
            }
        }
        
        /*
         do {
         let cityFetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
         let cityWeather = try context.fetch(cityFetchRequest).first
         
         guard let cityWeather else {
         fatalError("Erreur lors de la récupération des données de météo de \(name)")
         }
         print("[MeteoWeatherCoreDataService] ✅ Chargement de la météo de \(cityWeather.name ?? "??") terminée.")
         
         return cityWeather
         } catch let fetchError {
         print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo de \(name). \(fetchError)")
         
         fatalError("Erreur lors de la récupération des données de météo de \(name). \(fetchError)")
         }
         */
    }
     */
    
    public func fetchAllCities() -> [CityCurrentWeatherEntity] {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo. Contexte indisponible.")
            return []
        }
        
        let fetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
        
        do {
            let cities = try context.fetch(fetchRequest)
            print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
            return cities
        } catch let fetchError {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
            fatalError("Erreur lors de la récupération des données de météo: \(fetchError)")
        }
        
    }
    
    public func asyncFetchAllCities() async -> [CityCurrentWeatherEntity] {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo. Contexte indisponible.")
            return []
        }
        
        context.automaticallyMergesChangesFromParent = true
        
        let fetchRequest = NSFetchRequest<CityCurrentWeatherEntity>(entityName: "CityCurrentWeatherEntity")
        
        return context.performAndWait {
            do {
                let cities = try context.fetch(fetchRequest)
                print("[MeteoWeatherCoreDataService] ✅ Chargement des villes terminée.")
                return cities
            } catch let fetchError {
                print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération des données de météo: \(fetchError)")
                fatalError("Erreur lors de la récupération des données de météo: \(fetchError)")
            }
        }
    }
    
    // Main thread
    public func deleteCity(city: CityCurrentWeatherEntity) {
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération du contexte.")
            
            return
        }
        
        print("[MeteoWeatherCoreDataService] Suppression de \(city.name ?? "??")...")
        context.delete(city)
        saveData(operationDescription: "Suppression de \(city.name ?? "??")", context: context)
    }
    
    public func deleteAllCities() {
        print("[MeteoWeatherCoreDataService] Suppression des anciens contenus sauvegardés...")
        guard let context = persistentContainer?.viewContext else {
            print("[MeteoWeatherCoreDataService] ❌ Erreur lors de la récupération du contexte.")
            return
        }
        
        return context.performAndWait {
            do {
                try context.execute(deleteAllCitiesRequest)
                saveData(operationDescription: "Suppression de toutes les villes", context: context)
                // Save Data
                try context.save()
                print("[MeteoWeatherCoreDataService] ✅ Suppression terminée.")
            } catch {
                print("Une erreur est survenue lors de la suppression: \(error)")
            }
        }
    }
}
