//
//  MeteoWeatherDataRepositoryProtocol.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation

public protocol MeteoWeatherDataRepositoryProtocol: AnyObject {
    func searchCity(with query: String, completion: @escaping (Result<[GeocodedCity], MeteoWeatherDataError>) -> ())
    func addCity(with geocodedCity: GeocodedCity, completion: @escaping (Result<CityCurrentWeatherLocalEntity, MeteoWeatherDataError>) -> ())
    func fetchAllCities(completion: @escaping (Result<[CityCurrentWeatherLocalEntity], MeteoWeatherDataError>) -> ())
    func deleteCity(with name: String, completion: @escaping (Result<Void, MeteoWeatherDataError>) -> ())
}
