//
//  NetworkServiceDataTests.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import XCTest

final class NetworkServiceDataTests: XCTestCase {
    
    func testFetchGeocodedCitySuccess() async {
        let networkServiceCaller = NetworkTestServiceCaller()
        let result = await networkServiceCaller.fetchGeocodedCitySuccess()
        XCTAssertTrue(networkServiceCaller.invokedFetchGeocodedCity)
        XCTAssertEqual(networkServiceCaller.invokedFetchGeocodedCityCount, 1)
        
        switch result {
            case .success(let data):
                XCTAssertGreaterThan(data.count, 0)
            case .failure(_):
                XCTFail()
        }
    }
    
    func testFetchGeocodedCityFailure() async {
        let networkServiceCaller = NetworkTestServiceCaller()
        let result = await networkServiceCaller.fetchGeocodedCityFailure()
        XCTAssertTrue(networkServiceCaller.invokedFetchGeocodedCity)
        XCTAssertEqual(networkServiceCaller.invokedFetchGeocodedCityCount, 1)
        
        switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .apiError)
        }
    }
    
    func testFetchCurrentCityWeatherSuccess() async {
        let networkServiceCaller = NetworkTestServiceCaller()
        let result = await networkServiceCaller.fetchCurrentCityWeatherSuccess()
        XCTAssertTrue(networkServiceCaller.invokedFetchCurrentCityWeather)
        XCTAssertEqual(networkServiceCaller.invokedFetchCurrentCityWeatherCount, 1)
        
        switch result {
            case .success(let data):
                XCTAssertEqual(data.weather?[0].description ?? "", "peu nuageux")
            case .failure(_):
                XCTFail()
        }
    }
    
    func testFetchCurrentCityWeatherFailure() async {
        let networkServiceCaller = NetworkTestServiceCaller()
        let result = await networkServiceCaller.fetchCurrentCityWeatherFailure()
        XCTAssertTrue(networkServiceCaller.invokedFetchCurrentCityWeather)
        XCTAssertEqual(networkServiceCaller.invokedFetchCurrentCityWeatherCount, 1)
        
        switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .apiError)
        }
    }
    
    func testFetchGeocodedCitySuccess() {
        let networkServiceCaller = NetworkTestServiceCaller()
        let expectation = XCTestExpectation(description: "Closure with success should be executed")
        
        networkServiceCaller.fetchGeocodedCitySuccess { result in
            switch result {
                case .success(let data):
                    XCTAssertTrue(networkServiceCaller.invokedFetchGeocodedCity)
                    XCTAssertEqual(networkServiceCaller.invokedFetchGeocodedCityCount, 1)
                    XCTAssertGreaterThan(data.count, 0)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchGeocodedCityFailure() {
        let networkServiceCaller = NetworkTestServiceCaller()
        let expectation = XCTestExpectation(description: "Closure with failure should be executed")
        
        networkServiceCaller.fetchGeocodedCityFailure { result in
            switch result {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertTrue(networkServiceCaller.invokedFetchGeocodedCity)
                    XCTAssertEqual(networkServiceCaller.invokedFetchGeocodedCityCount, 1)
                    XCTAssertEqual(error, .apiError)
                    expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchCurrentCityWeatherSuccess() {
        let networkServiceCaller = NetworkTestServiceCaller()
        let expectation = XCTestExpectation(description: "Closure with success should be executed")
        
        networkServiceCaller.fetchCurrentCityWeatherSuccess { result in
            switch result {
                case .success(let data):
                    XCTAssertTrue(networkServiceCaller.invokedFetchCurrentCityWeather)
                    XCTAssertEqual(networkServiceCaller.invokedFetchCurrentCityWeatherCount, 1)
                    XCTAssertEqual(data.weather?[0].description ?? "", "peu nuageux")
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchCurrentCityWeatherFailure() {
        let networkServiceCaller = NetworkTestServiceCaller()
        let expectation = XCTestExpectation(description: "Closure with failure should be executed")
        
        networkServiceCaller.fetchCurrentCityWeatherFailure { result in
            switch result {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertTrue(networkServiceCaller.invokedFetchCurrentCityWeather)
                    XCTAssertEqual(networkServiceCaller.invokedFetchCurrentCityWeatherCount, 1)
                    XCTAssertEqual(error, .apiError)
                    expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
