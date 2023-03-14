//
//  ListPresenterTests.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import XCTest
@testable import MeteoWeather

final class ListPresenterTests: XCTestCase {
    
    var presenter: ListPresentationLogic?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = ListMockPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        let presenter = ListPresenter()
    }
    
    func testFailure() {
        
    }
}
