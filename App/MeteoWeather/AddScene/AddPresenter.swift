//
//  AddPresenter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

final class AddPresenter {
    // The VIP cycle requires a weak reference to avoid a memory leak: View -> Interactor -> Presenter -> View
    weak var view: AddDisplayLogic?
    
    private func parseViewModels(with cities: [CitySearchOutput]) -> [AddEntity.ViewModel.CityViewModel] {
        var viewModels = [AddEntity.ViewModel.CityViewModel]()
        cities.forEach { viewModels.append($0.getCityViewModel()) }
        return viewModels
    }
}

extension AddPresenter: AddPresentationLogic {
    func presentCities(response: AddEntity.SearchCity.Response) {
        print("6) [Add] Presenter -> View: Notification de la vue pour mise à jour avec la réponse.")
        switch response.result {
            case .success(let cities):
                print("-> 6.1) [Add] Presenter -> View: Notification de la vue avec les vues modèles.")
                view?.displaySearchResults(with: AddEntity.ViewModel(cellViewModels: parseViewModels(with: cities)))
            case .failure(let error):
                print("-> 6.1) [Add] Presenter -> View: Notification de la vue d'une erreur.")
                view?.displayErrorMessage(with: AddEntity.ViewModel.Error(message: error.rawValue))
        }
    }
    
    func notifyDataAddition(response: AddEntity.AddCity.Response) {
        switch response.result {
            case .success():
                print("-> 6.1) [Add] Presenter -> View: L'entité est ajoutée, la vue peut être fermée.")
                view?.dismissView()
            case .failure(let error):
                print("-> 6.1) [Add] Presenter -> View: Notification de la vue d'une erreur.")
                view?.displayErrorMessage(with: AddEntity.ViewModel.Error(message: error.rawValue))
        }
    }
}
