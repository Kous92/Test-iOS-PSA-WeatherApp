//
//  ListDisplayLogicMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeather

final class ListDisplayLogicMock: ListDisplayLogic {
    
    var invokedUpdateCityList = false
    var invokedUpdateCityListCount = 0
    var invokedUpdateCityListParameters = [MeteoWeather.ListEntity.ViewModel.CityViewModel]()
    
    var invokedDisplayErrorMessage = false
    var invokedDisplayErrorMessageCount = 0
    var invokedDisplayErrorMessageParameter = ""
    
    var invokedCompleteDeletion = false
    var invokedCompleteDeletionCount = 0
    var invokedCompleteDeletionParameter: IndexPath?
    
    func updateCityList(with viewModel: MeteoWeather.ListEntity.ViewModel) {
        invokedUpdateCityList = true
        invokedUpdateCityListCount += 1
        invokedUpdateCityListParameters = viewModel.cellViewModels
    }
    
    func displayErrorMessage(with viewModel: MeteoWeather.ListEntity.ViewModel.Error) {
        invokedDisplayErrorMessage = true
        invokedDisplayErrorMessageCount += 1
        invokedDisplayErrorMessageParameter = viewModel.message
    }
    
    func completeDeletion(at indexPath: IndexPath) {
        invokedCompleteDeletion = true
        invokedCompleteDeletionCount += 1
        invokedCompleteDeletionParameter = IndexPath(row: 0, section: 0)
    }
}

