//
//  ConvertFunctions.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

enum TimeOption {
    case hourTime
    case lastUpdate
}

// m/s to km/h (kph)
func convertSpeed(speed: Double) -> String {
    if speed == -1 {
        return "Indisponible"
    }
    
    return String(format: "%.2f km/h", speed * 3.6)
}

func parseTemperature(with temperature: Double) -> String {
    return "\(Int(round(temperature)))°C"
}

func getDateTimeFromUnixTimestamp(timestamp: String, option: TimeOption) -> String {
    var strDate = "Indisponible"
        
    if let unixTime = Double(timestamp) {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        
        switch option {
            case .hourTime:
                dateFormatter.dateFormat = "HH:mm"
            case .lastUpdate:
                dateFormatter.dateFormat = "dd/MM/yyyy à HH:mm"
        }
        
        strDate = dateFormatter.string(from: date)
    }
        
    return strDate
}

// From the ISO code, it gives the country full name.
func countryName(countryCode: String) -> String? {
    let current = Locale(identifier: "fr_FR")
    return current.localizedString(forRegionCode: countryCode)
}
