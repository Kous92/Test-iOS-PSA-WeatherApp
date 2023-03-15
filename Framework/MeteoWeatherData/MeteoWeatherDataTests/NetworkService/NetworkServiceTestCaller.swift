//
//  NetworkServiceTestCaller.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
import XCTest
@testable import MeteoWeatherData

final class NetworkTestServiceCaller {
    var invokedFetchGeocodedCity = false
    var invokedFetchGeocodedCityCount = 0
    var invokedFetchCurrentCityWeather = false
    var invokedFetchCurrentCityWeatherCount = 0
    
    func fetchGeocodedCitySuccess() async -> Result<[GeocodedCity], MeteoWeatherData.MeteoWeatherDataError> {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchGeocodedCity = true
        invokedFetchGeocodedCityCount += 1
        
        return await networkService.fetchGeocodedCity(query: "Paris")
    }
    
    func fetchGeocodedCityFailure() async -> Result<[GeocodedCity], MeteoWeatherData.MeteoWeatherDataError> {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchGeocodedCity = true
        invokedFetchGeocodedCityCount += 1
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        return await networkService.fetchGeocodedCity(query: "Dubai")
    }
    
    func fetchGeocodedCitySuccess(completion: @escaping (Result<[GeocodedCity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchGeocodedCity = true
        invokedFetchGeocodedCityCount += 1
        
        networkService.fetchGeocodedCity(query: "Paris", completion: completion)
    }
    
    func fetchGeocodedCityFailure(completion: @escaping (Result<[GeocodedCity], MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchGeocodedCity = true
        invokedFetchGeocodedCityCount += 1
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        networkService.fetchGeocodedCity(query: "Dubai", completion: completion)
    }
    
    func fetchCurrentCityWeatherSuccess() async -> Result<CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError> {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        return await networkService.fetchCurrentCityWeather(lat: 48.8646, lon: 2.3343)
    }
    
    func fetchCurrentCityWeatherFailure() async -> Result<CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError> {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        return await networkService.fetchCurrentCityWeather(lat: 0, lon: 0)
    }
    
    func fetchCurrentCityWeatherSuccess(completion: @escaping (Result<CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        networkService.fetchCurrentCityWeather(lat: 48.8646, lon: 2.3343, completion: completion)
    }
    
    func fetchCurrentCityWeatherFailure(completion: @escaping (Result<CityCurrentWeather, MeteoWeatherData.MeteoWeatherDataError>) -> ()) {
        let networkService: MeteoWeatherDataAPIService = MeteoWeatherDataMockAPIService(forceFetchAllFailure: false)
        invokedFetchCurrentCityWeather = true
        invokedFetchCurrentCityWeatherCount += 1
        
        networkService.fetchCurrentCityWeather(lat: 0, lon: 0, completion: completion)
    }
}
