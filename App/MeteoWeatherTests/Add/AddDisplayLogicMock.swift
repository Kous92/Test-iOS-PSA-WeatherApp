//
//  AddDisplayLogicMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeather

final class AddDisplayLogicMock: AddDisplayLogic {
    
    var invokedDisplaySearchResults = false
    var invokedDisplaySearchResultsCount = 0
    var invokedDisplaySearchResultsParameters = [AddEntity.ViewModel.CityViewModel]()
    
    var invokedDisplayErrorMessage = false
    var invokedDisplayErrorMessageCount = 0
    var invokedDisplayErrorMessageParameter = ""
    
    var invokedDismissView = false
    var invokedDismissViewCount = 0
    
    func displaySearchResults(with viewModel: AddEntity.ViewModel) {
        invokedDisplaySearchResults = true
        invokedDisplaySearchResultsCount += 1
        invokedDisplaySearchResultsParameters = viewModel.cellViewModels
    }
    
    func displayErrorMessage(with viewModel: AddEntity.ViewModel.Error) {
        invokedDisplayErrorMessage = true
        invokedDisplayErrorMessageCount += 1
        invokedDisplayErrorMessageParameter = viewModel.message
    }
    
    func dismissView() {
        invokedDismissView = true
        invokedDismissViewCount += 1
    }
}
