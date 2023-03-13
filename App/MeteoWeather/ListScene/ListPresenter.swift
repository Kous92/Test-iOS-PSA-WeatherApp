//
//  ListPresenter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import UIKit

final class ListPresenter {
    // The VIP cycle requires a weak reference to avoid a memory leak: View -> Interactor -> Presenter -> View
    weak var view: ListDisplayLogic?
    
    private func parseViewModels(with cities: [CityCurrentWeather]) -> [ListEntity.ViewModel.CityViewModel] {
        var viewModels = [ListEntity.ViewModel.CityViewModel]()
        cities.forEach { viewModels.append($0.getCityViewModel()) }
        return viewModels
    }
}

extension ListPresenter: ListPresentationLogic {
    func presentCities(response: ListEntity.Response) {
        print("6) [List] Presenter -> View: Notification de la vue pour mise à jour avec la réponse.")
        switch response.result {
            case .success(let cities):
                print("-> 6.1) Presenter -> View: Notification de la vue avec les vues modèles.")
                view?.updateCityList(with: ListEntity.ViewModel(cellViewModels: parseViewModels(with: cities)))
            case .failure(let error):
                print("-> 6.1) Presenter -> View: Notification de la vue d'une erreur.")
                view?.displayErrorMessage(with: ListEntity.ViewModel.Error(message: error.rawValue))
        }
    }
}
