//
//  AddPresenterTests.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import XCTest
@testable import MeteoWeather

final class AddPresenterTests: XCTestCase {
    func testSearchSuccess() {
        let presenter = AddPresenter()
        let view = AddDisplayLogicMock()
        presenter.view = view
        
        presenter.presentCities(response: AddEntity.SearchCity.Response(result: .success(CitySearchOutput.mockData())))
        XCTAssertTrue(view.invokedDisplaySearchResults)
        XCTAssertEqual(view.invokedDisplaySearchResultsCount, 1)
        XCTAssertGreaterThan(view.invokedDisplaySearchResultsParameters.count, 0)
    }
    
    func testSearchFailed() {
        let presenter = AddPresenter()
        let view = AddDisplayLogicMock()
        presenter.view = view
        
        presenter.presentCities(response: AddEntity.SearchCity.Response(result: .failure(.apiError)))
        XCTAssertTrue(view.invokedDisplayErrorMessage)
        XCTAssertEqual(view.invokedDisplayErrorMessageCount, 1)
        XCTAssertEqual(view.invokedDisplayErrorMessageParameter, "Une erreur est survenue.")
    }
    
    func testDismiss() {
        let view = AddDisplayLogicMock()
        view.dismissView()
        
        XCTAssertTrue(view.invokedDismissView)
        XCTAssertEqual(view.invokedDismissViewCount, 1)
    }

}
