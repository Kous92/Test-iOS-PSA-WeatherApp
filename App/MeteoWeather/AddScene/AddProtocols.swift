//
//  AddProtocols.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

// Presenter -> View
protocol AddDisplayLogic: AnyObject {
    func displaySearchResults(with viewModel: AddEntity.ViewModel)
    func displayErrorMessage(with viewModel: AddEntity.ViewModel.Error)
}

// View -> Interactor
protocol AddBusinessLogic: AnyObject {
    func searchCities(request: AddEntity.SearchCity.Request)
    func addSelectedCity(index: IndexPath)
}

// Interactor -> Presenter
protocol AddPresentationLogic: AnyObject {
    func presentCities(response: AddEntity.SearchCity.Response)
    func notifyDataAddition()
}

// View -> Router
protocol AddRoutingLogic: AnyObject {
    func backToListView()
}

// AddRouter -> ListRouter
protocol AddDataDelegate: AnyObject {
    func updateCityList()
}

// From the interactor, the data will be stored here. The router will retrieve the wanted data to pass it to an other view through an other DataStore.
protocol AddDataStore: AnyObject {
    var cities: [CitySearchOutput] { get }
}

protocol AddDataPassing {
    var dataStore: AddDataStore? { get }
}
