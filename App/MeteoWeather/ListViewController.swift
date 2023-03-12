//
//  ListViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 09/03/2023.
//

import UIKit
import MeteoWeatherData
import MapKit
import CoreLocation
import Combine

protocol AddDataDelegate: AnyObject {
    func updateData()
}

class ListViewController: UIViewController, AddDataDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let service = MeteoWeatherDataNetworkAPIService()
    var cities = [CityCurrentWeatherEntity]()
    
    var geocodedCities = [GeocodedCity]()
    @Published var searchQuery = ""
    private var subscriptions = Set<AnyCancellable>()
    
    var testData = ["Paris", "Londres", "Manchester", "Dubai"]
    let repository = MeteoWeatherDataRepository(networkService: MeteoWeatherDataNetworkAPIService())
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        $searchQuery
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] value in
                self?.searchCity(with: value)
            }.store(in: &subscriptions)
        
        cities = repository.fetchAllCities()
        tableView.reloadData()
    }
    
    func searchCity(with query: String) {
        Task {
            let result = await repository.searchCity(with: query)
            
            switch result {
                case .success(let cities):
                    print(cities)
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.geocodedCities = cities
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        self?.alertError(errorMessage: error.rawValue)
                    }
            }
        }
    }
    
    private func alertError(errorMessage: String) {
        let alert = UIAlertController(title: "Erreur", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        repository.updateCities { result in
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.cities = self.repository.fetchAllCities()
                        print(self.cities.count)
                        self.tableView.reloadData()
                        
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        self?.alertError(errorMessage: error.rawValue)
                    }
            }
            
            self.refreshControl.endRefreshing()
        }
        // Fetch Weather Data
        // fetchWeatherData()dataManager.weatherDataForLocation(latitude: 37.8267, longitude: -122.423) { (location, error) in
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        print("AddCityVC")
        
        guard let addViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {
            fatalError("La vue pour ajouter des villes n'est pas disponible !")
        }
        
        addViewController.updateDelegate = self
        self.navigationController?.present(addViewController, animated: true)
    }
    
    func updateData() {
        print("Update list")
        cities = repository.fetchAllCities()
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ouvrir la vue détail pour afficher toute la météo.")
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("La vue détail n'est pas disponible !")
        }
        
        detailViewController.cityWeather = cities[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? CityWeatherTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: cities[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let city = cities[indexPath.row]
            repository.deleteCity(with: city)
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}
