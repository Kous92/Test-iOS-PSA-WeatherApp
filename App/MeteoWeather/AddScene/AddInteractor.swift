//
//  AddInteractor.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

final class AddInteractor: AddDataStore {
    var cities = [CitySearchOutput]()
    var presenter: AddPresentationLogic?
    private var worker: AddWorker
    
    init(worker: AddWorker) {
        self.worker = worker
    }
}

extension AddInteractor: AddBusinessLogic {
    func searchCities(request: AddEntity.SearchCity.Request) {
        print("2) [Add] Interactor: Lancement de l'appel API depuis le Worker.")
        worker.searchCities(request: request) { [weak self] response in
            print("5) [Add] Interactor -> Presenter: Réponse récupérée, notification du Presenter")
            self?.prepareDataStore(with: response)
            self?.presenter?.presentCities(response: response)
        }
    }
    
    func addSelectedCity(request: AddEntity.AddCity.Request) {
        print("2) [Add] Interactor: Lancement de l'appel API depuis le Worker pour la sauvegarde de \(request.query).")
        guard let cityToAdd = getCityForAddition(with: request.query) else {
            print("Erreur: la ville à ajouter n'est pas présente")
            return
        }
        
        worker.addCity(with: cityToAdd) { [weak self] response in
            self?.presenter?.notifyDataAddition(response: response)
        }
    }
    
    private func prepareDataStore(with response: AddEntity.SearchCity.Response) {
        switch response.result {
            case .success(let cities):
                self.cities = cities
                print("-> 5.1) Interactor: Data Store mis à jour pour l'opération d'ajout.")
            default:
                return
        }
    }
    
    private func getCityForAddition(with name: String) -> CitySearchOutput? {
        return cities.filter { $0.getCityViewModel().name == name }.first
    }
}
