//
//  LocalServiceTestCaller.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
import XCTest
@testable import MeteoWeatherData

final class LocalTestServiceCaller {
    var invokedSaveCityWeatherData = false
    var invokedSaveCityWeatherDataCount = 0
    var invokedFetchAll = false
    var invokedFetchAllCount = 0
    var invokedDeleteCity = false
    var invokedDeleteCityCount = 0
    
    func fetchAllDataSuccess(completion: @escaping (Result<[MeteoWeatherData.CityCurrentWeatherLocalEntity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: false)
        invokedFetchAll = true
        invokedFetchAllCount += 1
        
        localService.fetchAllCities(completion: completion)
    }
    
    func fetchAllDataFailure(completion: @escaping (Result<[MeteoWeatherData.CityCurrentWeatherLocalEntity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: true)
        invokedFetchAll = true
        invokedFetchAllCount += 1
        
        localService.fetchAllCities(completion: completion)
    }
    
    func deleteCitySuccess(completion: @escaping (Result<Void, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: false)
        invokedDeleteCity = true
        invokedDeleteCityCount += 1
        
        localService.deleteCity(cityName: "Paris", completion: completion)
    }
    
    func deleteCityFailure(completion: @escaping (Result<Void, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: false)
        invokedDeleteCity = true
        invokedDeleteCityCount += 1
        
        localService.deleteCity(cityName: "Dubai", completion: completion)
    }
    
    func saveCitySuccess(completion: @escaping (Result<MeteoWeatherData.CityCurrentWeatherLocalEntity, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: false)
        invokedSaveCityWeatherData = true
        invokedSaveCityWeatherDataCount += 1
        
        localService.saveCityWeatherData(geocodedCity: GeocodedCity.dataMock(), currentWeather: MeteoWeatherData.CityCurrentWeather.dataMock(), completion: completion)
    }
    
    func saveCityFailure(completion: @escaping (Result<MeteoWeatherData.CityCurrentWeatherLocalEntity, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let localService: MeteoWeatherLocalService = MeteoWeatherMockLocalService(forceFetchAllFailure: false)
        invokedSaveCityWeatherData = true
        invokedSaveCityWeatherDataCount += 1
        
        localService.saveCityWeatherData(geocodedCity: MeteoWeatherData.GeocodedCity.failureDataMock(), currentWeather: MeteoWeatherData.CityCurrentWeather.dataMock(), completion: completion)
    }
}
