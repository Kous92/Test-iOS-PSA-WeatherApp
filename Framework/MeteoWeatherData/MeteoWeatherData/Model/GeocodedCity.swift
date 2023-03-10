//
//  GeocodedCity.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public struct GeocodedCity: Decodable {
    public let name: String
    public let localNames: [String: String]?
    public let lat, lon: Double
    public let country: String
    public let state: String?
    
    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case name, lat, lon, country, state
    }
}
