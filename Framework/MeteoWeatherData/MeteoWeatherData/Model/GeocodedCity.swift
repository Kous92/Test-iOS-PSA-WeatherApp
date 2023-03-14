//
//  GeocodedCity.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

/// The output data structure from OpenWeather Geocoding API, it represents the location with his name and GPS position. This object is Decodable because it can be decoded from a JSON output after an HTTP call to OpenWeather Geocoding API.
public struct GeocodedCity: Decodable {
    /// Name of the found location
    public let name: String
    
    /// Name of the found location in different languages. The list of names can be different for different locations. Key: language code ("fr", "en", "es", ...), value: translated name with the associated language.
    public let localNames: [String: String]?
    
    /// Geographical coordinates of the found location (latitude)
    public let lat: Double
    
    /// Geographical coordinates of the found location (longitude)
    public let lon: Double
    
    /// Country of the found location, represented with ISO code.
    public let country: String
    
    /// State of the found location, if available
    public let state: String?
    
    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case name, lat, lon, country, state
    }
    
    /// Initialize a geocoded city.
    /// - Parameters:
    ///   - name: Name of the found location
    ///   - localNames: Name of the found location in different languages. The list of names can be different for different locations. Key: language code ("fr", "en", "es", ...), value: translated name with the associated language.
    ///   - lat: Geographical coordinates of the found location (latitude)
    ///   - lon: Geographical coordinates of the found location (longitude)
    ///   - country: Country of the found location, represented with ISO code.
    ///   - state: State of the found location, where available
    public init(name: String, localNames: [String : String]?, lat: Double, lon: Double, country: String, state: String?) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
}
