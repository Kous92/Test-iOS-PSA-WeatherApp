//
//  CitySearchOutputDataMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeather

extension CitySearchOutput {
    static func mockData() -> [CitySearchOutput] {
        let data = CitySearchOutput(name: "Dubai", localNames: ["en": "Dubai", "fr": "Dubaï"], lat: 25.2653471, lon: 55.2924914, country: "AE")
        
        return [data]
    }
}
