//
//  DetailInteractor.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

final class DetailInteractor: DetailDataStore, DetailBusinessLogic {
    var cityWeather: CityCurrentWeatherOutput?
    var presenter: DetailPresenter?
    
    func getPassedCityWeather() {
        if let cityWeather {
            presenter?.presentDetails(response: DetailEntity.WeatherDetails.Response(cityWeather: cityWeather))
        }
    }
}
