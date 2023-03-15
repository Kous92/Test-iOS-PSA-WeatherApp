//
//  CityCurrentWeatherDataMock.swift
//  MeteoWeatherTests
//
//  Created by Koussaïla Ben Mamar on 15/03/2023.
//

import Foundation
@testable import MeteoWeather
@testable import MeteoWeatherData

extension CityCurrentWeatherOutput {
    static func mockData() -> [CityCurrentWeatherOutput] {
        let data = CityCurrentWeatherOutput(name: "Paris", country: "France", weatherIcon: "04d", weatherDescription: "Peu nuageux", temperature: 7.11, feelsLike: 5.35, tempMin: 6.28, tempMax: 7.71, lon: 2.3856, lat: 48.8543, sunset: 1678902855, sunrise: 1678860292, pressure: 1019, humidity: 79, cloudiness: 10000, windSpeed: 2.57, windGust: 8.94, oneHourRain: 10, oneHourSnow: 1, lastUpdateTime: 1678872960)
        
        return [data]
    }
}

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

extension GeocodedCity {
    static func dataMock() -> GeocodedCity {
        let json =
        """
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
        }
        """.data(using: .utf8)

        let decoder = JSONDecoder()
        let data = try! decoder.decode(GeocodedCity.self, from: json!)

        return data
    }
    
    static func failureDataMock() -> GeocodedCity {
        let json = """
        {
            "name": "Dubai",
            "local_names": {
                "pt": "Dubai",
                "jv": "Dubai",
                "fo": "Dubai",
                "fa": "دبی",
                "yo": "Dubai",
                "sv": "Dubai",
                "uz": "Dubay",
                "hi": "दुबई",
                "lb": "Dubai",
                "tt": "Дөбәй",
                "it": "Dubai",
                "fi": "Dubai",
                "eo": "Dubajurbo",
                "mn": "Дубай",
                "lt": "Dubajus",
                "pl": "Dubaj",
                "ne": "दुबई",
                "sk": "Dubaj",
                "be": "Дубай",
                "gd": "Dubai",
                "se": "Dubai",
                "ks": "دبئی",
                "te": "దుబాయ్",
                "yi": "דוביי",
                "nl": "Dubai",
                "ps": "دوبۍ",
                "tg": "Дубай",
                "cv": "Дубай",
                "th": "ดูไบ",
                "kw": "Dubai",
                "sd": "دبئي",
                "fy": "ELDûbai",
                "uk": "Дубай",
                "et": "Dubai",
                "sr": "Дубаи",
                "kn": "ದುಬೈ",
                "lv": "Dubaija",
                "io": "Dubai",
                "mk": "Дубаи",
                "hy": "Դուբայ",
                "hu": "Dubaj",
                "ur": "دبئی",
                "kk": "Дубай",
                "sw": "Dubai",
                "os": "Дубай",
                "ki": "Dubai",
                "ja": "ドバイ",
                "tl": "Dubai",
                "ta": "துபாய்",
                "ny": "Dubai",
                "ha": "Dubai",
                "ar": "دبي",
                "eu": "Dubai",
                "fr": "Dubaï",
                "ie": "Dubai",
                "oc": "Dubai",
                "ko": "두바이",
                "he": "דובאי",
                "de": "Dubai",
                "my": "ဒူဘိုင်းမြို့",
                "af": "Doebai",
                "tk": "Dubaý",
                "cs": "Dubaj",
                "bs": "Dubai",
                "ku": "Dubey",
                "si": "ඩුබායි",
                "li": "Dubai",
                "id": "Dubai",
                "an": "Dubai",
                "gn": "Nduvái",
                "ms": "Dubai",
                "ba": "Дубай",
                "sl": "Dubaj",
                "en": "Dubai",
                "mr": "दुबई",
                "ug": "دۇبائى",
                "sq": "Dubai",
                "so": "Dubay",
                "is": "Dúbaí",
                "no": "Dubai",
                "br": "Dubai",
                "bh": "दुबई",
                "gl": "Dubai",
                "zh": "迪拜",
                "ml": "ദുബായ്",
                "cy": "Dubai",
                "am": "ዱባይ",
                "as": "ডুবাই",
                "bg": "Дубай",
                "ro": "Dubai",
                "gu": "દુબઇ",
                "ky": "Дубай",
                "es": "Dubái",
                "el": "Ντουμπάι",
                "vo": "Dubayy",
                "ga": "Dubai",
                "vi": "Dubai",
                "da": "Dubai",
                "ru": "Дубай",
                "pa": "ਦੁਬਈ",
                "hr": "Dubai",
                "tr": "Dubai",
                "ka": "დუბაი"
            },
            "lat": 25.2653471,
            "lon": 55.2924914,
            "country": "AE",
            "state": "Dubai"
        }
        """.data(using: .utf8)

        let decoder = JSONDecoder()
        let data = try! decoder.decode(GeocodedCity.self, from: json!)

        return data
    }
}
