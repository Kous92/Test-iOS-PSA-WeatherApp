//
//  ListMockPresenter.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import Foundation
@testable import MeteoWeather

final class ListMockPresenter: ListPresentationLogic {
    weak var view: ListDisplayLogic?
    
    func presentCities(response: MeteoWeather.ListEntity.Response) {
        // view?.updateCityList(with: )
        
        // view?.displayErrorMessage(with: "")
    }
    
    func notifyDeletion(response: MeteoWeather.ListEntity.DeleteCity.Response) {
    }
}
