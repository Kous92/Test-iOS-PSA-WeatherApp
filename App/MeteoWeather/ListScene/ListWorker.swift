//
//  ListWorker.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import MeteoWeatherData

final class ListWorker {
    private var repository: MeteoWeatherDataRepositoryProtocol?
    
    init(repository: MeteoWeatherDataRepositoryProtocol) {
        // Network calls are not needed
        self.repository = repository
    }
    
    func fetchCitiesData(completion: @escaping (_ response: ListEntity.Response) -> ()) {
        print("3) [List] Worker: Récupération des données locales s'il y en a.")
        repository?.fetchAllCities { [weak self] result in
            if let self {
                completion(self.handleResult(with: result))
            }
        }
    }
    
    func deleteCityData(request: ListEntity.DeleteCity.Request, completion: @escaping (_ response: ListEntity.DeleteCity.Response) -> ()) {
        print("3) [List] Worker: Lancement de la suppression des données de \(request.name).")
        repository?.deleteCity(with: request.name) { result in
            switch result {
                case .success():
                    print("-> 4.1) [List] Suppression terminée de \(request.name).")
                    completion(ListEntity.DeleteCity.Response(result: .success(request.index)))
                case .failure(let error):
                    print("-> 4.1) [List] Échec: une erreur est survenue.")
                    completion(ListEntity.DeleteCity.Response(result: .failure(error)))
            }
        }
    }
    
    private func handleResult(with result: Result<[CityCurrentWeatherLocalEntity], MeteoWeatherDataError>) -> ListEntity.Response {
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
    
    private func parseToLocalAppEntities(with entities: [CityCurrentWeatherLocalEntity]) -> [CityCurrentWeatherOutput] {
        var localEntities = [CityCurrentWeatherOutput]()
        entities.forEach { localEntities.append(CityCurrentWeatherOutput(with: $0)) }
        
        return localEntities
    }
}
