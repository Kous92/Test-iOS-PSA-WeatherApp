//
//  AddModels.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation
import MeteoWeatherData

enum AddEntity {
    enum SearchCity {
        struct Request {
            let query: String
        }
        
        struct Response {
            let result: Result<[CitySearchOutput], MeteoWeatherDataError>
        }
    }
    
    enum AddCity {
        struct Request {
            let query: String
        }
        
        struct Response {
            let result: Result<Void, MeteoWeatherDataError>
        }
    }
    
    struct ViewModel {
        struct CityViewModel {
            let name: String
        }
        
        var cellViewModels: [CityViewModel]
        
        struct Error {
            let message: String
        }
    }
}
