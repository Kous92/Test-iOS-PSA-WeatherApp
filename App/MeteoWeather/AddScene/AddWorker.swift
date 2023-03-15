//
//  AddWorker.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation
import MeteoWeatherData

final class AddWorker {
    private var repository: MeteoWeatherDataRepositoryProtocol?
    
    init(repository: MeteoWeatherDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchCities(request: AddEntity.SearchCity.Request, completion: @escaping (_ response: AddEntity.SearchCity.Response) -> ()) {
        print("3) [Add] Worker: Recherche de villes pour \(request.query)...")
        repository?.searchCity(with: request.query) { [weak self] result in
            if let self {
                completion(self.handleResult(with: result))
            }
        }
    }
    
    func addCity(with city: CitySearchOutput, completion: @escaping (_ response: AddEntity.AddCity.Response) -> ()) {
        let geocodedCity = city.getGeocodedCity()
        print("3) [Add] Worker: Ajout de la météo de \(city.name)...")
        repository?.addCity(with: geocodedCity) { result in
            print("4) [Add] Worker: Renvoi de la réponse à l'Interactor.")
            switch result {
                case .success(let entity):
                    print("-> 4.1) [Add] Les données de \(entity.name) ont été sauvegardées en base locale.")
                    completion(AddEntity.AddCity.Response(result: .success(())))
                case .failure(let error):
                    print("-> 4.1) [Add] Échec: une erreur est survenue.")
                    completion(AddEntity.AddCity.Response(result: .failure(error)))
            }
        }
    }
    
    private func handleResult(with result: Result<[GeocodedCity], MeteoWeatherDataError>) -> AddEntity.SearchCity.Response {
        print("4) [Add] Worker: Renvoi de la réponse à l'Interactor.")
        switch result {
            case .success(let output):
                let localEntities = parseToLocalAppEntities(with: filterDuplicates(output))
                print("-> [Add] 4.1) Succès: \(localEntities.count) articles récupérés.")
                return AddEntity.SearchCity.Response(result: .success(localEntities))
            case .failure(let error):
                print("-> [Add] 4.1) Échec: une erreur est survenue.")
                return AddEntity.SearchCity.Response(result: .failure(error))
        }
    }
    
    private func parseToLocalAppEntities(with entities: [GeocodedCity]) -> [CitySearchOutput] {
        var localEntities = [CitySearchOutput]()
        entities.forEach { localEntities.append(CitySearchOutput(with: $0)) }
        
        return localEntities
    }
    
    // The API may return duplicated cities (format: City, State, Country)
    private func filterDuplicates(_ data: [GeocodedCity]) -> [GeocodedCity] {
        // Useless if it's a singleton
        guard data.count > 1 else {
            return data
        }

        var dictionary = [String: Bool]()
        
        return data.filter { city in
            let filterName = city.name + "," + (city.state ?? "") + ", " + city.country
            return dictionary.updateValue(true, forKey: filterName) == nil
        }
    }
}
