//
//  ListWorker.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import MeteoWeatherData

final class ListWorker {
    private var repository: MeteoWeatherDataRepository
    
    init() {
        self.repository = MeteoWeatherDataRepository(networkService: MeteoWeatherDataNetworkAPIService())
    }
    
    func fetchCitiesData(completion: @escaping (_ response: ListEntity.Response) -> ()) {
        print("3) [List] Worker: Récupération des données locales s'il y en a.")
        repository.fetchAllCities { [weak self] result in
            if let self {
                completion(self.handleResult(with: result))
            }
        }
    }
    
    private func handleResult(with result: Result<[CityCurrentWeatherEntity], MeteoWeatherDataError>) -> ListEntity.Response {
        print("4) [List] Worker: Renvoi de la réponse à l'Interactor.")
        switch result {
            case .success(let output):
                let localEntities = parseToLocalAppEntities(with: output)
                print("-> 4.1) [List] Succès: \(localEntities.count) articles récupérés.")
                return ListEntity.Response(result: .success(localEntities))
            case .failure(let error):
                print("-> 4.1) [List] Échec: une erreur est survenue.")
                return ListEntity.Response(result: .failure(error))
        }
    }
    
    private func parseToLocalAppEntities(with entities: [CityCurrentWeatherEntity]) -> [CityCurrentWeather] {
        var localEntities = [CityCurrentWeather]()
        entities.forEach { localEntities.append(CityCurrentWeather(with: $0)) }
        
        return localEntities
    }
}
