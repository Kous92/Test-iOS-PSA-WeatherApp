//
//  CityCurrentWeather.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public struct CityCurrentWeather: Decodable {
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let snow: Snow?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
}

// MARK: - Clouds
public struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Main
public struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain
public struct Rain: Decodable {
    let oneHour: Double?
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

// MARK: - Rain
public struct Snow: Decodable {
    let oneHour: Double?
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

// MARK: - Sys
public struct Sys: Decodable {
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
public struct Weather: Decodable {
    let description, icon: String?
}

// MARK: - Wind
public struct Wind: Decodable {
    let speed: Double?
    let gust: Double?
}
