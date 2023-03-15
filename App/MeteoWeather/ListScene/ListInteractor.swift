//
//  ListInteractor.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation

final class ListInteractor: ListDataStore {
    // Data Store
    var cities = [CityCurrentWeatherOutput]()
    var presenter: ListPresentationLogic?
    private var worker: ListWorker
    
    init(worker: ListWorker) {
        self.worker = worker
    }
}

extension ListInteractor: ListBusinessLogic {
    func deleteCity(request: ListEntity.DeleteCity.Request) {
        print("2) [List] Interactor: Lancement de l'appel API depuis le Worker.")
        worker.deleteCityData(request: request) { [weak self] response in
            print("5) [List] Interactor -> Presenter: Réponse récupérée, notification du Presenter")
            self?.presenter?.notifyDeletion(response: response)
        }
    }
    
    func fetchCities() {
        print("2) [List] Interactor: Lancement de l'appel API depuis le Worker.")
        worker.fetchCitiesData { [weak self] response in
            print("5) Interactor -> Presenter: Réponse récupérée, notification du Presenter")
            self?.prepareDataStore(with: response)
            self?.presenter?.presentCities(response: response)
        }
    }
    
    private func prepareDataStore(with response: ListEntity.Response) {
        switch response.result {
            case .success(let entities):
                self.cities = entities
                print("-> [List] 5.1) Interactor: Data Store mis à jour pour le routeur.")
            default:
                return
        }
    }
}
