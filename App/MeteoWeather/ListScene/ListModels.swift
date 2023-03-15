//
//  ListModels.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import MeteoWeatherData

enum ListEntity {
    enum DeleteCity {
        struct Request {
            let name: String
            let index: IndexPath
        }
        
        struct Response {
            let result: Result<IndexPath, MeteoWeatherDataError>
        }
    }
    
    struct Response {
        let result: Result<[CityCurrentWeatherOutput], MeteoWeatherDataError>
    }
    
    struct ViewModel {
        struct CityViewModel {
            let name: String
            let weatherDescription: String
            let iconImage: String
            let temperature: String
            let minTemperature: String?
            let maxTemperature: String?
        }
        
        var cellViewModels: [CityViewModel]
        
        struct Error {
            let message: String
        }
    }
}
