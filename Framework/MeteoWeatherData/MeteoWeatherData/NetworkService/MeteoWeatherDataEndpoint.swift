//
//  MeteoWeatherDataEndpoint.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import Foundation

/// This enumeration manages the URL to build dynamically, regarding the different API endpoints of OpenWeather API. Use with a networking service for any HTTP requests.
enum MeteoWeatherDataEndpoint {
    /// The URL with Geocoding API endpoint, with city name to geocode as input parameter
    case geocoding(cityName: String)
    
    /// The URL with Current weather data endpoint, with GPS coordinates (latitude and longiture) of a location.
    case currentWeather(lat: Double, lon: Double)
    
    /// The base URL of OpenWeather API
    var baseURL: String {
        return "https://api.openweathermap.org"
    }
    
    /// The endpoint depending of the given parameter, to concatenate with base URL
    var path: String {
        switch self {
            case .geocoding(cityName: let cityName):
                return "/geo/1.0/direct?q=\(cityName)&limit=5"
            case .currentWeather(lat: let lat, lon: let lon):
                return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&lang=fr&units=metric"
        }
    }
}
