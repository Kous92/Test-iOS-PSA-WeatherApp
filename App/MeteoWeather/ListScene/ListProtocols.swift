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
    func completeDeletion(at indexPath: IndexPath)
}

// View -> Interactor
protocol ListBusinessLogic: AnyObject {
    func fetchCities()
    func deleteCity(request: ListEntity.DeleteCity.Request)
}

// Interactor -> Presenter
protocol ListPresentationLogic: AnyObject {
    func presentCities(response: ListEntity.Response)
    func notifyDeletion(response: ListEntity.DeleteCity.Response)
}

// View -> Router
protocol ListRoutingLogic: AnyObject {
    func showDetailView(at indexPath: IndexPath)
    func showAddView()
    func updateFromAddView()
}

// From the interactor, the data will be stored here. The router will retrieve the wanted data to pass it to an other view through an other DataStore.
protocol ListDataStore: AnyObject {
    var cities: [CityCurrentWeatherOutput] { get }
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

