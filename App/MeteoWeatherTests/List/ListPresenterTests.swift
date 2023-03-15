//
//  ListPresenterTests.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import XCTest
@testable import MeteoWeather

final class ListPresenterTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        let presenter = ListPresenter()
        let view = ListDisplayLogicMock()
        presenter.view = view
        
        presenter.presentCities(response: ListEntity.Response(result: .success(CityCurrentWeatherOutput.mockData())))
        XCTAssertTrue(view.invokedUpdateCityList)
        XCTAssertEqual(view.invokedUpdateCityListCount, 1)
        XCTAssertGreaterThan(view.invokedUpdateCityListParameters.count, 0)
    }
    
    func testFailure() {
        let presenter = ListPresenter()
        let view = ListDisplayLogicMock()
        presenter.view = view
        
        presenter.presentCities(response: ListEntity.Response(result: .failure(.apiError)))
        XCTAssertTrue(view.invokedDisplayErrorMessage)
        XCTAssertEqual(view.invokedDisplayErrorMessageCount, 1)
        XCTAssertEqual(view.invokedDisplayErrorMessageParameter, "Une erreur est survenue.")
    }
    
    func testDataDeletionSuccess() {
        let presenter = ListPresenter()
        let view = ListDisplayLogicMock()
        presenter.view = view
        
        presenter.notifyDeletion(response: ListEntity.DeleteCity.Response(result: .success(IndexPath(row: 0, section: 0))))
        XCTAssertTrue(view.invokedCompleteDeletion)
        XCTAssertEqual(view.invokedCompleteDeletionCount, 1)
        XCTAssertNotNil(view.invokedCompleteDeletionParameter)
    }
    
    func testDataDeletionFailure() {
        let presenter = ListPresenter()
        let view = ListDisplayLogicMock()
        presenter.view = view
        
        presenter.notifyDeletion(response: ListEntity.DeleteCity.Response(result: .failure(.localDatabaseDeleteError)))
        XCTAssertFalse(view.invokedCompleteDeletion)
        XCTAssertEqual(view.invokedCompleteDeletionCount, 0)
        XCTAssertNil(view.invokedCompleteDeletionParameter)
    }
}
