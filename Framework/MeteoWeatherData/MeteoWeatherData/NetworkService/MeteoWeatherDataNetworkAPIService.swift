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
    
    public func fetchCurrentCityWeather(lat: Double, lon: Double) async -> Result<CityCurrentWeather, MeteoWeatherDataError> {
        await getRequest(endpoint: .currentWeather(lat: lat, lon: lon))
    }
    
    public func fetchGeocodedCity(query: String, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ()) {
        getRequest(endpoint: .geocoding(cityName: query), completion: completion)
    }
    
    public func fetchCurrentCityWeather(lat: Double, lon: Double, completion: @escaping (Result<CityCurrentWeather, MeteoWeatherDataError>) -> ()) {
        getRequest(endpoint: .currentWeather(lat: lat, lon: lon), completion: completion)
    }
    
    private func getRequest<T: Decodable>(endpoint: MeteoWeatherDataEndpoint) async -> Result<T, MeteoWeatherDataError> {
        guard let encodedUrlString = encodeURL(with: endpoint.baseURL + endpoint.path + "&appId=\(apiKey)"),
              let url = URL(string: encodedUrlString) else {
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
    
    private func getRequest<T: Decodable>(endpoint: MeteoWeatherDataEndpoint, completion: @escaping (Result<T, MeteoWeatherDataError>) -> ()) {
        guard let encodedUrlString = encodeURL(with: endpoint.baseURL + endpoint.path + "&appId=\(apiKey)"),
              let url = URL(string: encodedUrlString) else {
            print("URL invalide.")
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.networkError))
                print("DataTask error: \(error.localizedDescription)")
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Erreur: Pas de réponse du serveur.")
                completion(.failure(.apiError))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Erreur code \(httpResponse.statusCode).")
                completion(.failure(self.getErrorMessage(with: httpResponse.statusCode)))
                return
            }
            
            guard let data else {
                print("Données indisponibles")
                completion(.failure(.apiError))
                return
            }
            
            print("Code: \(httpResponse.statusCode)")
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                print("Erreur: Le décodage a échoué. \(error.localizedDescription)")
                completion(.failure(.decodeError))
            }
        }
        dataTask.resume()
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
    
    private func encodeURL(with string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
