//
//  CityCurrentWeatherMock.swift
//  MeteoWeatherDataTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeatherData

extension CityCurrentWeather {
    public static func dataMock() -> CityCurrentWeather {
        let json =
        """
        {
            "coord": {
                "lon": 2.3856,
                "lat": 48.8543
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "peu nuageux",
                    "icon": "02d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 7.11,
                "feels_like": 5.35,
                "temp_min": 6.28,
                "temp_max": 7.71,
                "pressure": 1019,
                "humidity": 79
            },
            "visibility": 10000,
            "wind": {
                "speed": 2.57,
                "deg": 240
            },
            "clouds": {
                "all": 20
            },
            "dt": 1678872850,
            "sys": {
                "type": 2,
                "id": 2041230,
                "country": "FR",
                "sunrise": 1678860292,
                "sunset": 1678902855
            },
            "timezone": 3600,
            "id": 2994540,
            "name": "Paris",
            "cod": 200
        }
        """.data(using: .utf8)
        
        let decoder = JSONDecoder()
        let data = try! decoder.decode(CityCurrentWeather.self, from: json!)
        
        return data
    }
}
