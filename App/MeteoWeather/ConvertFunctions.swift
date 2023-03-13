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
    let kph = speed * 3.6
    
    return "\(kph) km/h"
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