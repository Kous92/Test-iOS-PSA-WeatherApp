//
//  MeteoWeatherDataNetworkAPIService.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public final class MeteoWeatherDataNetworkAPIService: MeteoWeatherDataAPIService {
    private var apiKey: String = "ab4ec97922530bc9f0dd33517d2d433b"
    
    public init() {
        
    }
    
    public func fetchGeocodedCity(query: String) async -> Result<[GeocodedCity], MeteoWeatherDataError> {
        await getRequest(endpoint: .geocoding(cityName: query))
    }
    
    public func fetchCurrentCityWeather(lon: Double, lat: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError> {
        await getRequest(endpoint: .currentWeather(lat: lat, lon: lon))
    }
    
    public func fetchAirPollution(lon: Double, lat: Double) async -> Result<AirPollution, MeteoWeatherDataError> {
        await getRequest(endpoint: .airPollution(lat: lat, lon: lon))
    }
    
    private func getRequest<T: Decodable>(endpoint: MeteoWeatherDataEndpoint) async -> Result<T, MeteoWeatherDataError> {
        guard let url = URL(string: endpoint.baseURL + endpoint.path + "&appId=\(apiKey)") else {
            print("URL invalide.")
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print(url.absoluteString)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Pas de réponse du serveur.")
                return .failure(.networkError)
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Erreur code \(httpResponse.statusCode).")
                return .failure(getErrorMessage(with: httpResponse.statusCode))
            }
            
            print("Code: \(httpResponse.statusCode)")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                var outputData: T
                outputData = try decoder.decode(T.self, from: data)
                return .success(outputData)
            } catch {
                return .failure(.decodeError)
            }
        } catch {
            print("ERREUR: \(error.localizedDescription)")
        }
        
        return .failure(.unknown)
    }
    
    private func getErrorMessage(with code: Int) -> MeteoWeatherDataError {
        let errorMessage: MeteoWeatherDataError
        
        switch code {
            case 401:
                errorMessage = .invalidApiKey
            case 404:
                errorMessage = .notFound
            case 429:
                errorMessage = .tooManyRequests
            case 500, 501, 502, 503:
                errorMessage = .serverError
            default:
                errorMessage = .downloadError
        }
        
        return errorMessage
    }
}
