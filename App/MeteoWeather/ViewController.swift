//
//  ViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import UIKit
import MeteoWeatherData

class ViewController: UIViewController {

    let service = MeteoWeatherDataNetworkAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let test1 = WeatherData()
        print(test1.getData())
        
        let airPollution = test1.testDecodingAirPollution()
        print("Index qualité de l'air: \(airPollution.list[0].main.aqi)")
        
        let geocoded = test1.testDecodingGeocodedCity()
        print(geocoded)
        
        // let cityWeather = test1.testDecodingCurrentWeather()
        // print(cityWeather)
        
        Task {
            print("Étape 1: Géocodage de la ville de Paris")
            let geocodedOutput = await service.fetchGeocodedCity(query: "Paris")
            
            switch geocodedOutput {
                case .success(let geocoded):
                    print(geocoded)
                    await fetchWeather(with: geocoded[0])
                    await fetchAirPollution(with: geocoded[0])
                case .failure(let error):
                    print(error.rawValue)
            }

            // await fetchWeather()
        }
    }
    
    @MainActor private func fetchWeather(with geocodedCity: GeocodedCity) async {
        print("Étape 2: Récupération des conditions météo de la ville de Paris")
        let cityWeatherOutput = await service.fetchCurrentCityWeather(lon: geocodedCity.lon, lat: geocodedCity.lat)
        
        switch cityWeatherOutput {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error.rawValue)
        }
    }
    
    @MainActor private func fetchWeather() async {
        print("Étape 2: Récupération des conditions météo de la ville de Paris")
        
        let cityWeatherOutput = await service.fetchCurrentCityWeather(lon: 2.3200410217200766, lat: 48.8588897)
        
        switch cityWeatherOutput {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error.rawValue)
        }
    }
    
    @MainActor private func fetchAirPollution(with geocodedCity: GeocodedCity) async {
        print("Étape 3: Récupération de la qualité de l'air de la ville de Paris")
        
        let airPollutionOutput = await service.fetchAirPollution(lon: 2.3200410217200766, lat: 48.8588897)
        
        switch airPollutionOutput {
            case .success(let airPollution):
                print(airPollution)
            case .failure(let error):
                print(error.rawValue)
        }
    }
}
