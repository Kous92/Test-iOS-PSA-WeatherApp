//
//  AddViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit
import Combine
import MeteoWeatherData

final class AddViewController: UIViewController {
    let repository = MeteoWeatherDataRepository(networkService: MeteoWeatherDataNetworkAPIService())
    var geocodedCities = [GeocodedCity]()
    
    private var interactor: AddBusinessLogic?
    var router: (AddRoutingLogic)?
    private var viewModels = [AddEntity.ViewModel.CityViewModel]()
    
    private var updatedResult = PassthroughSubject<Bool, Never>()
    private var isLoading = PassthroughSubject<Bool, Never>()
    @Published private var searchQuery = ""
    private var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var updateDelegate: AddDataDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Setting Clean Swift components
    private func setup() {
        let interactor = AddInteractor()
        let presenter = AddPresenter()
        let router = AddRouter()
        interactor.presenter = presenter
        presenter.view = self
        router.addViewController = self
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        setBindings()
    }
    
    private func setBindings() {
        $searchQuery
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] value in
                print("1) [Add] View: Exécution de l'action de recherche...")
                // self?.searchCity(with: value)
                self?.interactor?.searchCities(request: AddEntity.SearchCity.Request(query: value))
            }.store(in: &subscriptions)
        
        isLoading
            .receive(on: DispatchQueue.main)
            .sink { /*[weak self]*/ isLoading in
                if isLoading {
                    /*
                    self?.spinner.startAnimating()
                    self?.spinner.isHidden = false
                    self?.articleTableView.isHidden = true
                     */
                }
            }.store(in: &subscriptions)
        
        updatedResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updated in
                if updated {
                    self?.tableView.reloadData()
                }
            }.store(in: &subscriptions)
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
}

extension AddViewController: AddDisplayLogic {
    func displaySearchResults(with viewModel: AddEntity.ViewModel) {
        self.viewModels = viewModel.cellViewModels
        updatedResult.send(true)
    }
    
    func displayErrorMessage(with viewModel: AddEntity.ViewModel.Error) {
        alertError(errorMessage: viewModel.message)
    }
}

extension AddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // addAndSaveSelectedCity(with: geocodedCities[indexPath.row])
    }
    
    func addAndSaveSelectedCity(with city: GeocodedCity) {
        print("Ajout de \(city.localNames?["fr"] ?? city.name)")
        repository.addCity(with: city) { result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        print(data)
                        print("Ready to dismiss.")
                        self?.updateDelegate?.updateCityList()
                        self?.dismiss(animated: true)
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        self?.alertError(errorMessage: error.rawValue)
                    }
                    return
            }
        }
    }
}

extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
        // geocodedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        /*
        var place = ""
        if let name = geocodedCities[indexPath.row].localNames?["fr"] {
            place += name
        } else {
            place += geocodedCities[indexPath.row].name
        }
        
        if let state = geocodedCities[indexPath.row].state {
            place += ", \(state)"
        }
        
        place += " \(geocodedCities[indexPath.row].country)"
         */
        
        cell.textLabel?.text = viewModels[indexPath.row].name
        
        return cell
    }
}

extension AddViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
}
