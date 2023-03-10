//
//  AirPollutionData.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import Foundation

public struct AirPollution: Decodable {
    public let coord: Coordinates
    public let list: [AirPollutionData]
}

public struct Coordinates: Decodable {
    public let lon, lat: Double
}

// dt: DateTime
// components (Polluting gases): Carbon monoxide (CO), Nitrogen monoxide (NO), Nitrogen dioxide (NO2), Ozone (O3), Sulphur dioxide (SO2), Ammonia (NH3), and suspending particulates (PM2.5 and PM10).
public struct AirPollutionData: Decodable {
    public let main: AirQuality
    public let components: [String: Double]?
    public let dt: Int
}

// aqi: Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
public struct AirQuality: Decodable {
    public let aqi: Int
}
