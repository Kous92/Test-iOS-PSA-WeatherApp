//
//  LocalServiceDataTests.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import XCTest
@testable import MeteoWeatherData

final class LocalServiceDataTests: XCTestCase {

    func testFetchDataSuccess() {
        let localServiceCaller = LocalTestServiceCaller()
        let expectation = XCTestExpectation(description: "Closure with success should be executed")
        
        localServiceCaller.fetchAllDataSuccess { result in
            switch result {
                case .success(let data):
                    XCTAssertTrue(localServiceCaller.invokedFetchAll)
                    XCTAssertEqual(localServiceCaller.invokedFetchAllCount, 1)
                    XCTAssertGreaterThan(data.count, 0)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("Failure case has been executed, expected success case.")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchDataFailure() {
        let localServiceCaller = LocalTestServiceCaller()
        let fetchFailureExpectation = XCTestExpectation(description: "Closure with failure should be executed")
        
        localServiceCaller.fetchAllDataFailure { result in
            switch result {
                case .success(_):
                    XCTFail("Success case has been executed, expected failure case.")
                case .failure(let error):
                    XCTAssertTrue(localServiceCaller.invokedFetchAll)
                    XCTAssertEqual(localServiceCaller.invokedFetchAllCount, 1)
                    XCTAssertEqual(error, .localDatabaseFetchError)
                    fetchFailureExpectation.fulfill()
            }
        }
        
        wait(for: [fetchFailureExpectation], timeout: 10)
    }
    
    func testSaveDataSuccess() {
        let localServiceCaller = LocalTestServiceCaller()
        let saveSuccessExpectation = XCTestExpectation(description: "Closure with saving success should be executed")
        
        localServiceCaller.saveCitySuccess { result in
            switch result {
                case .success(let data):
                    XCTAssertTrue(localServiceCaller.invokedSaveCityWeatherData)
                    XCTAssertEqual(localServiceCaller.invokedSaveCityWeatherDataCount, 1)
                    print(data)
                    XCTAssertEqual(data.name, "Paris")
                    saveSuccessExpectation.fulfill()
                case .failure(_):
                    XCTFail("Failure case has been executed, expected success case.")
            }
        }
        
        wait(for: [saveSuccessExpectation], timeout: 10)
    }
    
    func testSaveDataFailure() {
        let localServiceCaller = LocalTestServiceCaller()
        let saveFailureExpectation = XCTestExpectation(description: "Closure with saving failure should be executed")
        
        localServiceCaller.saveCityFailure { result in
            switch result {
                case .success(_):
                    XCTFail("Success case has been executed, expected failure case.")
                case .failure(let error):
                    XCTAssertTrue(localServiceCaller.invokedSaveCityWeatherData)
                    XCTAssertEqual(localServiceCaller.invokedSaveCityWeatherDataCount, 1)
                    XCTAssertEqual(error, .localDatabaseSavingError)
                    saveFailureExpectation.fulfill()
            }
        }
        
        wait(for: [saveFailureExpectation], timeout: 10)
    }
    
    func testDeleteDataSuccess() {
        let localServiceCaller = LocalTestServiceCaller()
        let deleteSuccessExpectation = XCTestExpectation(description: "Closure with success should be executed")
        
        localServiceCaller.deleteCitySuccess { result in
            switch result {
                case .success(_):
                    XCTAssertTrue(localServiceCaller.invokedDeleteCity)
                    XCTAssertEqual(localServiceCaller.invokedDeleteCityCount, 1)
                    deleteSuccessExpectation.fulfill()
                case .failure(_):
                    XCTFail("Failure case has been executed, expected success case.")
            }
        }
        
        wait(for: [deleteSuccessExpectation], timeout: 10)
    }
    
    func testDeleteDataFailure() {
        let localServiceCaller = LocalTestServiceCaller()
        let deleteFailureExpectation = XCTestExpectation(description: "Closure with failure should be executed")
        
        localServiceCaller.deleteCityFailure { result in
            switch result {
                case .success(_):
                    XCTFail("Success case has been executed, expected failure case.")
                case .failure(let error):
                    XCTAssertTrue(localServiceCaller.invokedDeleteCity)
                    XCTAssertEqual(localServiceCaller.invokedDeleteCityCount, 1)
                    XCTAssertEqual(error, .localDatabaseDeleteError)
                    deleteFailureExpectation.fulfill()
            }
        }
        
        wait(for: [deleteFailureExpectation], timeout: 10)
    }
}
