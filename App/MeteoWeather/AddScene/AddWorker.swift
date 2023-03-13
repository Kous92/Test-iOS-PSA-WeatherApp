//
//  AddWorker.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation
import MeteoWeatherData

final class AddWorker {
    private var repository: MeteoWeatherDataRepository
    
    init() {
        self.repository = MeteoWeatherDataRepository(networkService: MeteoWeatherDataNetworkAPIService())
    }
    
    func searchCities(request: AddEntity.SearchCity.Request, completion: @escaping (_ response: AddEntity.SearchCity.Response) -> ()) {
        print("3) [Add] Worker: Recherche de villes pour \(request.query)...")
        repository.searchCity(with: request.query) { [weak self] result in
            if let self {
                completion(self.handleResult(with: result))
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
