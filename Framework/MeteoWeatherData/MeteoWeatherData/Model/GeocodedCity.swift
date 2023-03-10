//
//  GeocodedCity.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public struct GeocodedCity: Decodable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case name, lat, lon, country, state
    }
}
