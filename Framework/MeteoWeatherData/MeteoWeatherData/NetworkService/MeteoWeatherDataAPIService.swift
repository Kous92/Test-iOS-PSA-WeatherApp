//
//  MeteoWeatherDataAPIService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public protocol MeteoWeatherDataAPIService {
    func fetchGeocodedCity(query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError>
    func fetchCurrentCityWeather(lon: Double, lat: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError>
    func fetchAirPollution(lon: Double, lat: Double) async -> Result<AirPollution, MeteoWeatherDataError>
}
