//
//  DetailProtocols.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

// Presenter -> View
protocol DetailDisplayLogic: AnyObject {
    func displayDetails(with viewModel: DetailEntity.WeatherDetails.ViewModel)
}

// View -> Interactor
protocol DetailBusinessLogic: AnyObject {
    func getPassedCityWeather()
}

// Interactor -> Presenter
protocol DetailPresentationLogic: AnyObject {
    func presentDetails(response: DetailEntity.WeatherDetails.Response)
}

// Depuis l'Interactor, les données seront stockées. Particularité, ce Data Store sera initialisé avec une donnée du routeur provenant d'un autre Data Store
protocol DetailDataStore: AnyObject {
    var cityWeather: CityCurrentWeatherOutput? { get set }
}

// The router have only data retrieval from previous view as responsibility
protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}
