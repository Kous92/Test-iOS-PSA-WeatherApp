//
//  WeatherData.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import Foundation

public class WeatherData {
    public init() {
        
    }
    
    public func getData() -> [String] {
        return ["Paris", "Londres", "Madrid", "Monaco", "Rome", "Alger", "Abu Dhabi", "New York", "Tokyo"]
    }
    
    public func testDecodingGeocodedCity() -> [GeocodedCity] {
        let json =
        """
        [
            {
                "name": "Paris",
                "local_names": {
                    "fi": "Pariisi",
                    "it": "Parigi",
                    "an": "París",
                    "ru": "Париж",
                    "tk": "Pariž",
                    "li": "Paries",
                    "fr": "Paris",
                    "gv": "Paarys",
                    "lt": "Paryžius",
                    "ar": "باريس",
                    "es": "París",
                    "ku": "Parîs",
                    "tt": "Париж",
                    "la": "Lutetia",
                    "ug": "پارىژ",
                    "hi": "पैरिस",
                    "mk": "Париз",
                    "de": "Paris",
                    "vi": "Paris",
                    "eu": "Paris",
                    "nl": "Parijs",
                    "ko": "파리",
                    "bs": "Pariz",
                    "sl": "Pariz",
                    "pa": "ਪੈਰਿਸ",
                    "ja": "パリ",
                    "mr": "पॅरिस",
                    "kv": "Париж",
                    "bo": "ཕ་རི།",
                    "uk": "Париж",
                    "ha": "Pariis",
                    "el": "Παρίσι",
                    "sq": "Parisi",
                    "ba": "Париж",
                    "ka": "პარიზი",
                    "hy": "Փարիզ",
                    "ga": "Páras",
                    "sv": "Paris",
                    "be": "Парыж",
                    "eo": "Parizo",
                    "fy": "Parys",
                    "wa": "Paris",
                    "gn": "Parĩ",
                    "zh": "巴黎",
                    "ps": "پاريس",
                    "tg": "Париж",
                    "mn": "Парис",
                    "ta": "பாரிஸ்",
                    "cs": "Paříž",
                    "no": "Paris",
                    "wo": "Pari",
                    "gl": "París",
                    "os": "Париж",
                    "or": "ପ୍ୟାରିସ",
                    "ur": "پیرس",
                    "ln": "Pari",
                    "lb": "Paräis",
                    "cu": "Парижь",
                    "am": "ፓሪስ",
                    "za": "Bahliz",
                    "yi": "פאריז",
                    "sr": "Париз",
                    "yo": "Parisi",
                    "hr": "Pariz",
                    "hu": "Párizs",
                    "tl": "Paris",
                    "fa": "پاریس",
                    "sk": "Paríž",
                    "so": "Baariis",
                    "ml": "പാരിസ്",
                    "ca": "París",
                    "cv": "Парис",
                    "is": "París",
                    "te": "పారిస్",
                    "br": "Pariz",
                    "af": "Parys",
                    "mi": "Parī",
                    "pl": "Paryż",
                    "ht": "Pari",
                    "th": "ปารีส",
                    "ne": "पेरिस",
                    "km": "ប៉ារីស",
                    "sh": "Pariz",
                    "co": "Parighji",
                    "et": "Pariis",
                    "gu": "પૅરિસ",
                    "kk": "Париж",
                    "kn": "ಪ್ಯಾರಿಸ್",
                    "uz": "Parij",
                    "sc": "Parigi",
                    "zu": "IParisi",
                    "bn": "প্যারিস",
                    "lv": "Parīze",
                    "my": "ပါရီမြို့",
                    "bg": "Париж",
                    "ky": "Париж",
                    "he": "פריז",
                    "oc": "París"
                },
                "lat": 48.8588897,
                "lon": 2.3200410217200766,
                "country": "FR",
                "state": "Ile-de-France"
            },
            {
                "name": "Paris",
                "local_names": {
                    "sq": "Parisi",
                    "bn": "প্যারিস",
                    "vi": "Paris",
                    "fi": "Pariisi",
                    "gl": "París",
                    "zh": "巴黎",
                    "km": "ប៉ារីស",
                    "ar": "باريس",
                    "wo": "Pari",
                    "sr": "Париз",
                    "ku": "Parîs",
                    "hy": "Փարիզ",
                    "bo": "ཕ་རི།",
                    "os": "Париж",
                    "tg": "Париж",
                    "cv": "Парис",
                    "pl": "Paryż",
                    "tl": "Paris",
                    "mk": "Париз",
                    "zu": "IParisi",
                    "en": "Paris",
                    "no": "Paris",
                    "lt": "Paryžius",
                    "ht": "Pari",
                    "ca": "París",
                    "sl": "Pariz",
                    "ha": "Pariis",
                    "bg": "Париж",
                    "ml": "പാരിസ്",
                    "uk": "Париж",
                    "it": "Parigi",
                    "yi": "פאריז",
                    "br": "Pariz",
                    "ug": "پارىژ",
                    "gd": "Paras",
                    "so": "Baariis",
                    "nl": "Parijs",
                    "ja": "パリ",
                    "eo": "Parizo",
                    "fr": "Paris",
                    "tk": "Pariž",
                    "ba": "Париж",
                    "mn": "Парис",
                    "gu": "પૅરિસ",
                    "lb": "Paräis",
                    "fy": "Parys",
                    "or": "ପ୍ୟାରିସ",
                    "et": "Pariis",
                    "de": "Paris",
                    "he": "פריז",
                    "ln": "Pari",
                    "tt": "Париж",
                    "cs": "Paříž",
                    "hu": "Párizs",
                    "ga": "Páras",
                    "el": "Παρίσι",
                    "fa": "پاریس",
                    "za": "Bahliz",
                    "ru": "Париж",
                    "hi": "पैरिस",
                    "lv": "Parīze",
                    "kk": "Париж",
                    "an": "París",
                    "gn": "Parĩ",
                    "uz": "Parij",
                    "th": "ปารีส",
                    "ka": "პარიზი",
                    "eu": "Paris",
                    "ko": "파리",
                    "ta": "பாரிஸ்",
                    "gv": "Paarys",
                    "is": "París",
                    "bs": "Pariz",
                    "co": "Parighji",
                    "sk": "Paríž",
                    "sc": "Parigi",
                    "es": "París",
                    "ps": "پاريس",
                    "yo": "Parisi",
                    "ur": "پیرس",
                    "pt": "Paris",
                    "te": "పారిస్",
                    "sv": "Paris",
                    "mr": "पॅरिस",
                    "cu": "Парижь",
                    "pa": "ਪੈਰਿਸ",
                    "am": "ፓሪስ",
                    "sh": "Pariz",
                    "kn": "ಪ್ಯಾರಿಸ್",
                    "oc": "París",
                    "af": "Parys",
                    "mi": "Parī",
                    "be": "Парыж",
                    "ky": "Париж",
                    "la": "Lutetia",
                    "ne": "पेरिस",
                    "hr": "Pariz",
                    "my": "ပါရီမြို့",
                    "li": "Paries",
                    "kv": "Париж"
                },
                "lat": 48.8534951,
                "lon": 2.3483915,
                "country": "FR",
                "state": "Ile-de-France"
            },
            {
                "name": "Paris",
                "lat": 33.6617962,
                "lon": -95.555513,
                "country": "US",
                "state": "Texas"
            },
            {
                "name": "Paris",
                "lat": 38.2097987,
                "lon": -84.2529869,
                "country": "US",
                "state": "Kentucky"
            },
            {
                "name": "Paris",
                "local_names": {
                    "wo": "Pari",
                    "ht": "Pari",
                    "hi": "पैरिस",
                    "uk": "Париж",
                    "ha": "Pariis",
                    "is": "París",
                    "hr": "Pariz",
                    "el": "Παρίσι",
                    "nl": "Parijs",
                    "ln": "Pari",
                    "sk": "Paríž",
                    "an": "París",
                    "te": "పారిస్",
                    "eu": "Paris",
                    "no": "Paris",
                    "ta": "பாரிஸ்",
                    "yo": "Parisi",
                    "gn": "Parĩ",
                    "pa": "ਪੈਰਿਸ",
                    "ru": "Париж",
                    "lv": "Parīze",
                    "zh": "巴黎",
                    "bs": "Pariz",
                    "mr": "पॅरिस",
                    "pl": "Paryż",
                    "ja": "パリ",
                    "th": "ปารีส",
                    "kk": "Париж",
                    "sl": "Pariz",
                    "mn": "Парис",
                    "km": "ប៉ារីស",
                    "sv": "Paris",
                    "bg": "Париж",
                    "yi": "פאריז",
                    "hu": "Párizs",
                    "ka": "პარიზი",
                    "zu": "IParisi",
                    "bn": "প্যারিস",
                    "hy": "Փարիզ",
                    "uz": "Parij",
                    "ko": "파리",
                    "sr": "Париз",
                    "ar": "باريس",
                    "oc": "París",
                    "tg": "Париж",
                    "kn": "ಪ್ಯಾರಿಸ್",
                    "gv": "Paarys",
                    "ky": "Париж",
                    "bo": "ཕ་རི།",
                    "cs": "Paříž",
                    "br": "Pariz",
                    "es": "París",
                    "am": "ፓሪስ",
                    "cu": "Парижь",
                    "af": "Parys",
                    "os": "Париж",
                    "mk": "Париз",
                    "so": "Baariis",
                    "ur": "پیرس",
                    "sq": "Parisi",
                    "lt": "Paryžius",
                    "et": "Pariis",
                    "za": "Bahliz",
                    "mi": "Parī",
                    "tt": "Париж",
                    "it": "Parigi",
                    "ps": "پاريس",
                    "ku": "Parîs",
                    "kv": "Париж",
                    "li": "Paries",
                    "cv": "Парис",
                    "vi": "Paris",
                    "fr": "Paris",
                    "la": "Lutetia",
                    "tk": "Pariž",
                    "sh": "Pariz",
                    "ml": "പാരിസ്",
                    "ug": "پارىژ",
                    "gu": "પૅરિસ",
                    "my": "ပါရီမြို့",
                    "sc": "Parigi",
                    "eo": "Parizo",
                    "tl": "Paris",
                    "ga": "Páras",
                    "he": "פריז",
                    "fi": "Pariisi",
                    "or": "ପ୍ୟାରିସ",
                    "be": "Парыж",
                    "de": "Paris",
                    "co": "Parighji",
                    "ca": "París",
                    "gl": "París",
                    "fy": "Parys",
                    "lb": "Paräis",
                    "ne": "पेरिस",
                    "fa": "پاریس",
                    "ba": "Париж"
                },
                "lat": 48.8588897,
                "lon": 2.3200410217200766,
                "country": "FR",
                "state": "Ile-de-France"
            }
        ]
        """.data(using: .utf8)
        
        let decoder = JSONDecoder()
        let data = try! decoder.decode([GeocodedCity].self, from: json!)
        
        return data
    }
    
    public func testDecodingCurrentWeather() -> CityCurrentWeather {
        let json =
        """
        {
            "coord": {
                "lon": 2.2957,
                "lat": 49.8942
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "couvert",
                    "icon": "04d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 7.64,
                "feels_like": 2.56,
                "temp_min": 7.32,
                "temp_max": 8.51,
                "pressure": 991,
                "humidity": 90,
                "sea_level": 991,
                "grnd_level": 987
            },
            "visibility": 10000,
            "wind": {
                "speed": 12.42,
                "deg": 274,
                "gust": 18.58
            },
            "clouds": {
                "all": 96
            },
            "dt": 1678441428,
            "sys": {
                "type": 2,
                "id": 2011713,
                "country": "FR",
                "sunrise": 1678428977,
                "sunset": 1678470382
            },
            "timezone": 3600,
            "id": 3037854,
            "name": "Amiens",
            "cod": 200
        }
        """.data(using: .utf8)
        
        let decoder = JSONDecoder()
        let data = try! decoder.decode(CityCurrentWeather.self, from: json!)
        
        return data
    }
    
    /*
    private func geocodeCity(with name: String) {
        Task {
            print("Géocodage de la ville de \(name)")
            let geocodedOutput = await service.fetchGeocodedCity(query: name)
            
            switch geocodedOutput {
                case .success(let geocoded):
                    let geo = geocoded.compactMap { city in
                        let name = city.localNames?["fr"] ?? city.name
                        let country = city.country
                        let state = city.state
                        
                        if let state {
                            return "\(name), \(state), \(country)"
                        }
                        
                        return "\(name)\(country)"
                    }
                    
                    print(geo)
                case .failure(let error):
                    print(error.rawValue)
            }
        }
    }
    
    private func forwardGeocodeCity(with name: String) {
        lazy var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(name) { placemarks, error in
            guard error == nil else {
                print("Géocodage impossible, erreur: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let placemarks else {
                print("Géocodage impossible (placemark)")
                return
            }
            
            let places = placemarks.compactMap { $0 }
            print(places)
        }
    }
    
    private func forwardGeocodeCity2(with name: String) {
        lazy var geocoder = CLGeocoder()
        
        let mkRequest = MKLocalSearch.Request()
        mkRequest.naturalLanguageQuery = name
        let localSearch = MKLocalSearch(request: mkRequest)
        localSearch.start { response, error in
            guard error == nil else {
                print("Recherche impossible: \(error!.localizedDescription)")
                return
            }
            
            guard let mapItems = response?.mapItems else {
                print("Aucun lieu trouvé")
                return
            }
            
            for place in mapItems {
                print(place)
            }
        }
        
        geocoder.geocodeAddressString(name, in: nil, preferredLocale: Locale(identifier: "fr-FR")) { placemarks, error in
            guard error == nil else {
                print("Géocodage impossible, erreur: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let placemarks else {
                print("Géocodage impossible (placemark)")
                return
            }
            
            let places = placemarks.compactMap { $0 }
            print(places)
        }
    }
    
    private func fetchWeather(with geocodedCity: GeocodedCity) async -> CityCurrentWeather {
        print("Étape 2: Récupération des conditions météo de la ville de \(city)")
        let cityWeatherOutput = await service.fetchCurrentCityWeather(lat: geocodedCity.lat, lon: geocodedCity.lon)
        
        switch cityWeatherOutput {
            case .success(let weather):
                print(weather)
                return weather
            case .failure(let error):
                fatalError(error.rawValue)
        }
    }
    
    @MainActor private func fetchWeather() async {
        print("Étape 2: Récupération des conditions météo de la ville de \(city)")
        
        let cityWeatherOutput = await service.fetchCurrentCityWeather(lat: 48.8588897, lon: 2.3200410217200766)
        
        switch cityWeatherOutput {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error.rawValue)
        }
    }
    
    /*
    private func fetchAirPollution(with geocodedCity: GeocodedCity) async -> AirPollution {
        print("Étape 3: Récupération de la qualité de l'air de la ville de \(city)")
        
        let airPollutionOutput = await service.fetchAirPollution(lon: 2.3200410217200766, lat: 48.8588897)
        
        switch airPollutionOutput {
            case .success(let airPollution):
                print(airPollution)
                return airPollution
            case .failure(let error):
                print(error.rawValue)
                fatalError(error.rawValue)
        }
    }
     */
    
    private func fetchCityAndSave(name: String) {
        Task {
            print("Étape 1: Géocodage de la ville de \(name)")
            let geocodedOutput = await service.fetchGeocodedCity(query: name)
            
            switch geocodedOutput {
                case .success(let geocoded):
                    print(geocoded)
                    let cityWeatherOutput = await fetchWeather(with: geocoded[0])
                    print(cityWeatherOutput)
                    print("\n")
                    // let airPollutionOutput = await fetchAirPollution(with: geocoded[0])
                    // print(airPollutionOutput)
                    print("\n")
                    print("Étape 4: Sauvegarde des données téléchargées vers la base Core Data")
                    await MeteoWeatherCoreDataService.shared.saveCityWeatherData(geocodedCity: geocoded[0], currentWeather: cityWeatherOutput)
                    print("Étape 5: Vérification de l'existence des données")
                    
                    DispatchQueue.main.async {
                        print(MeteoWeatherCoreDataService.shared.checkSavedCities())
                        MeteoWeatherCoreDataService.shared.fetchCityWeather()
                    }

                case .failure(let error):
                    print(error.rawValue)
            }
        }
    }
     */
}
