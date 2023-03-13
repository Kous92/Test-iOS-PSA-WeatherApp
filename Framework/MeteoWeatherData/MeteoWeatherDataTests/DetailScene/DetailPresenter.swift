//
//  DetailPresenter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

final class DetailPresenter: DetailPresentationLogic {
    weak var view: DetailDisplayLogic?
    
    func presentDetails(response: DetailEntity.WeatherDetails.Response) {
        view?.displayDetails(with: DetailEntity.WeatherDetails.ViewModel(cityWeather: response.cityWeather))
    }
}
