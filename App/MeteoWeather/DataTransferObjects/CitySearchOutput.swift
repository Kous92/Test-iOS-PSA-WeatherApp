//
//  CitySearchOutput.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation
import MeteoWeatherData

// Data Transfer Object between app layer and data layer
struct CitySearchOutput {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country: String
    let state: String?
    
    init(with geocodedCity: GeocodedCity) {
        self.name = geocodedCity.name
        self.localNames = geocodedCity.localNames
        self.lat = geocodedCity.lat
        self.lon = geocodedCity.lon
        self.country = countryName(countryCode: geocodedCity.country) ?? geocodedCity.country
        self.state = geocodedCity.state
    }
    
    init(name: String, localNames: [String : String]? = nil, lat: Double, lon: Double, country: String, state: String? = nil) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
    
    func getCityViewModel() -> AddEntity.ViewModel.CityViewModel {
        return AddEntity.ViewModel.CityViewModel(
            name: self.getCityFullName()
        )
    }
    
    func getGeocodedCity() -> GeocodedCity {
        return GeocodedCity(
            name: self.name,
            localNames: self.localNames,
            lat: self.lat,
            lon: self.lon,
            country: self.country,
            state: self.state
        )
    }
    
    private func getCityFullName() -> String {
        var place = localNames?["fr"] ?? name
        
        if let state {
            place += ", \(state)"
        }
        
        place += ", \(country)"
        return place
    }
}
