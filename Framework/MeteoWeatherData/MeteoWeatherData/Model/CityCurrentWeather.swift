//
//  CityCurrentWeather.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public struct CityCurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let snow: Snow?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
public struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
public struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
public struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain
public struct Rain: Codable {
    let oneHour: Double?
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

// MARK: - Rain
public struct Snow: Codable {
    let oneHour: Double?
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

// MARK: - Sys
public struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
public struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
public struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
