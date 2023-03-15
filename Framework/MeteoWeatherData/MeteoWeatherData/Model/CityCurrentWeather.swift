//
//  CityCurrentWeather.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

/// The output data structure from OpenWeather Current weather data API, it represents the full current weather of the location. This object is Decodable because it can be decoded from a JSON output after an HTTP call to OpenWeather Current weather data API.
public struct CityCurrentWeather: Decodable {
    public let weather: [Weather]?
    public let base: String?
    public let main: Main?
    public let visibility: Int?
    public let wind: Wind?
    public let rain: Rain?
    public let snow: Snow?
    /// Cloudiness of the location, the visibility.
    public let clouds: Clouds?
    public let dt: Int?
    public let sys: Sys?
}

// MARK: - Clouds
/// This object represents the cloudiness of the location, the visibility.
public struct Clouds: Decodable {
    /// Cloudiness, in %
    public let all: Int?
}

// MARK: - Main
public struct Main: Decodable {
    public let temp, feelsLike, tempMin, tempMax: Double?
    public let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain
/// This object represents the volume of the rain.
public struct Rain: Decodable {
    /// Rain volume for the last hour, in mm, if available
    public let oneHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

// MARK: - Snow
/// This object represents the volume of the snow.
public struct Snow: Decodable {
    /// Snow volume for the last hour, in mm, if available
    public let oneHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

// MARK: - Sys
/// This object represents the sunset and sunrise time
public struct Sys: Decodable {
    /// Country code ("GB", "EN", ...)
    public let country: String?
    
    /// Sunrise time, unix, UTC
    public let sunrise: Int?

    /// Sunset time, unix, UTC
    public let sunset: Int?
}

// MARK: - Weather
/// This object describes the actual weather condition (raining, cloud, snowing, sunny,...)
public struct Weather: Decodable {
    /// Weather condition within the group.
    public let description: String?
    
    /// Weather icon ID. Make sure the image you will set have the same name as the icon ID.
    public let icon: String?
}

// MARK: - Wind
/// This object represents the wind with his speed and the gust
public struct Wind: Decodable {
    /// Wind speed, in m/s
    public let speed: Double?
    
    /// Wind gust, in m/s
    public let gust: Double?
}
