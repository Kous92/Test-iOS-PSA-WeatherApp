//
//  Endpoints.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import Foundation

enum MeteoWeatherDataEndpoint {
    case geocoding(cityName: String)
    case currentWeather(lat: String, lon: String)
    case airPollution(lat: String, lon: String)
    
    var baseURL: String {
        return "https://api.openweathermap.org"
    }
    
    var path: String {
        switch self {
            case .geocoding(cityName: let cityName):
                return "/geo/1.0/direct?q=\(cityName)"
            case .currentWeather(lat: let lat, lon: let lon):
                return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&lang=fr&units=metric"
            case .airPollution(lat: let lat, lon: let lon):
                return "/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)"
        }
    }
}
