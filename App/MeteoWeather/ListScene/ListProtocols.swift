//
//  ListProtocols.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation

// Presenter -> View
protocol ListDisplayLogic: AnyObject {
    func updateCityList(with viewModel: ListEntity.ViewModel)
    func displayErrorMessage(with viewModel: ListEntity.ViewModel.Error)
}

// View -> Interactor
protocol ListBusinessLogic: AnyObject {
    func fetchCities()
}

// Interactor -> Presenter
protocol ListPresentationLogic: AnyObject {
    func presentCities(response: ListEntity.Response)
}

// View -> Router
protocol ListRoutingLogic: AnyObject {
    func showDetailView()
    func showAddView()
}

// From the interactor, the data will be stored here. The router will retrieve the wanted data to pass it to an other view through an other DataStore.
protocol ListDataStore: AnyObject {
    var cities: [CityCurrentWeather] { get }
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

