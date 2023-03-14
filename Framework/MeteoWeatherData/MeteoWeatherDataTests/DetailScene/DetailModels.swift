//
//  DetailModels.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

enum DetailStatsType {
    case wind
    case temperature
    case rain
    case snow
    case sunset
    case pressure
    case humidity
    case cloudiness
}

enum DetailEntity {
    enum WeatherDetails {
        struct Response {
            var cityWeather: CityCurrentWeather
        }
        
        struct WindViewModel {
            let windSpeed: String?
            let windGust: String?
            
            init(windSpeed: String?, windGust: String?) {
                self.windSpeed = windSpeed
                self.windGust = windGust
            }
        }
        
        struct RainSnowViewModel {
            let type: String
            let oneHourVolume: String
            
            init(type: String, oneHourVolume: String) {
                self.type = type
                self.oneHourVolume = oneHourVolume
            }
        }
        
        struct TemperatureViewModel {
            let feelingTemperature: String?
            let minTemperature: String?
            let maxTemperature: String?
            
            internal init(feelingTemperature: String, minTemperature: String, maxTemperature: String) {
                self.feelingTemperature = feelingTemperature
                self.minTemperature = minTemperature
                self.maxTemperature = maxTemperature
            }
        }
        
        struct SunsetSunriseViewModel {
            let sunset: String
            let sunrise: String
            
            init(sunset: String, sunrise: String) {
                self.sunset = sunset
                self.sunrise = sunrise
            }
        }
        
        struct OtherWeatherStatsViewModel {
            let description: String
            let value: String
            let imageName: String
            
            init(description: String, value: String, imageName: String) {
                self.description = description
                self.value = value
                self.imageName = imageName
            }
        }
        
        struct ViewModel {
            let name: String
            let country: String
            let weatherIcon: String
            let weatherDescription: String
            let temperature: String
            let temperatureFeeling: String
            let minTemperature: String
            let maxTemperature: String
            let sunset: String
            let sunrise: String
            let pressure: String
            let humidity: String
            let cloudiness: String
            let windSpeed: String
            let windGust: String
            let oneHourRain: String
            let oneHourSnow: String
            let lastUpdateTime: String
            
            // Some data may not be available
            let temperatureAvailable: Bool
            let temperatureFeelingAvailable: Bool
            let minTemperatureAvailable: Bool
            let maxTemperatureAvailable: Bool
            let oneHourSnowAvailable: Bool
            let oneHourRainAvailable: Bool
            let windSpeedAvailable: Bool
            let windGustAvailable: Bool
            
            // -999 are default values if data was not available from the network API for temperatures
            // -1 are default values if data was not available from the network API for others
            init(cityWeather: CityCurrentWeather) {
                self.name = cityWeather.name
                self.country = cityWeather.country
                self.weatherIcon = cityWeather.weatherIcon
                self.weatherDescription = cityWeather.weatherDescription.prefix(1).capitalized + cityWeather.weatherDescription.dropFirst().lowercased()
                self.temperature = cityWeather.temperature != -999 ? parseTemperature(with: cityWeather.temperature) : "??°C"
                self.temperatureAvailable = cityWeather.temperature != -999
                self.temperatureFeeling = cityWeather.feelsLike != -999 ? parseTemperature(with: cityWeather.feelsLike) : "??°C"
                self.temperatureFeelingAvailable = cityWeather.feelsLike != -999
                self.minTemperature = cityWeather.tempMin != -999 ? parseTemperature(with: cityWeather.tempMin) : "??°C"
                self.minTemperatureAvailable = cityWeather.tempMin != -999
                self.maxTemperature = cityWeather.tempMax != -999 ? parseTemperature(with: cityWeather.tempMax) : "??°C"
                self.maxTemperatureAvailable = cityWeather.tempMax != 999
                self.sunset = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunset), option: .hourTime)
                self.sunrise = getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.sunrise), option: .hourTime)
                self.pressure = "\(cityWeather.pressure) hPa"
                self.humidity = "\(cityWeather.humidity) %"
                self.cloudiness = "\(cityWeather.cloudiness) %"
                self.windSpeed = cityWeather.windSpeed != 1 ? convertSpeed(speed: cityWeather.windSpeed) : "Aucune rafale de vent"
                self.windSpeedAvailable = cityWeather.windSpeed != 1
                self.windGust = convertSpeed(speed: cityWeather.windGust)
                self.windGustAvailable = cityWeather.windGust != 1
                self.oneHourRain = cityWeather.oneHourRain != -1 ? "\(round(cityWeather.oneHourRain)) mm" : "Aucune pluie"
                self.oneHourRainAvailable = cityWeather.oneHourRain != -1
                self.oneHourSnow = cityWeather.oneHourSnow != -1 ? "\(round(cityWeather.oneHourSnow)) mm" : "Aucune chute de neige"
                self.oneHourSnowAvailable = cityWeather.oneHourSnow != -1
                self.lastUpdateTime = "Mise à jour: \(getDateTimeFromUnixTimestamp(timestamp: String(cityWeather.lastUpdateTime), option: .lastUpdate))"
            }
            
            func getCellConfigurations() -> [DetailStatsType] {
                var types = [DetailStatsType]()
                types.append(.sunset)
                
                if temperatureFeelingAvailable && minTemperatureAvailable && maxTemperatureAvailable {
                    types.append(.temperature)
                }
                
                if windSpeedAvailable || windGustAvailable {
                    types.append(.wind)
                }
                
                if oneHourRainAvailable {
                    types.append(.rain)
                }
                
                if oneHourSnowAvailable {
                    types.append(.snow)
                }
                
                types += [.pressure, .humidity, .cloudiness]
                return types
            }
            func getTemperatureViewModel() -> TemperatureViewModel {
                return TemperatureViewModel(feelingTemperature: self.temperatureFeeling, minTemperature: self.minTemperature, maxTemperature: self.maxTemperature)
            }
            
            func getWindViewModel() -> WindViewModel {
                return WindViewModel(windSpeed: self.windSpeed, windGust: self.windGust)
            }
            
            func getRainViewModel() -> RainSnowViewModel {
                return RainSnowViewModel(type: "Pluie", oneHourVolume: self.oneHourRain)
            }
            
            func getSnowViewModel() -> RainSnowViewModel {
                return RainSnowViewModel(type: "Neige", oneHourVolume: self.oneHourSnow)
            }
            
            func getSunsetSunriseViewModel() -> SunsetSunriseViewModel {
                return SunsetSunriseViewModel(sunset: self.sunset, sunrise: self.sunrise)
            }
            
            func getHumidityViewModel() -> OtherWeatherStatsViewModel {
                return OtherWeatherStatsViewModel(description: "Humidité", value: self.humidity, imageName: "humidity.fill")
            }
            
            func getVisibilityViewModel() -> OtherWeatherStatsViewModel {
                return OtherWeatherStatsViewModel(description: "Visibilité", value: self.cloudiness, imageName: "eye")
            }
            
            func getPressureViewModel() -> OtherWeatherStatsViewModel {
                return OtherWeatherStatsViewModel(description: "Pression", value: self.pressure, imageName: "arrow.up")
            }
        }
    }
}
