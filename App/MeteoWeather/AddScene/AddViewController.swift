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
    // Clean Swift
    private var interactor: AddBusinessLogic?
    var router: (AddRoutingLogic)?
    private var viewModels = [AddEntity.ViewModel.CityViewModel]()
    
    // Asynchronous subscribers. Every update will occur in the main thread
    private var updatedResult = PassthroughSubject<Void, Never>()
    private var isLoading = PassthroughSubject<Bool, Never>()
    private var addedCity = PassthroughSubject<Void, Never>()
    private var errorOccurred = PassthroughSubject<String, Never>()
    @Published private var searchQuery = ""
    private var subscriptions = Set<AnyCancellable>() // Prevent memory leaks
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
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
        let repository = MeteoWeatherDataRepository(networkService: MeteoWeatherDataNetworkAPIService(), localService: MeteoWeatherCoreDataService.shared)
        let interactor = AddInteractor(worker: AddWorker(repository: repository))
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
        setViews()
        setBindings()
    }
    
    private func setViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Search bar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .label
        searchBar.backgroundImage = UIImage() // No background
        searchBar.showsCancelButton = false
        searchBar.delegate = self
    }
    
    private func setBindings() {
        $searchQuery
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] value in
                print("1) [Add] View: Exécution de l'action de recherche...")
                self?.isLoading.send(true)
                self?.interactor?.searchCities(request: AddEntity.SearchCity.Request(query: value))
            }.store(in: &subscriptions)
        
        isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingUpdateViews(isLoading: true)
                } else {
                    self?.loadingUpdateViews(isLoading: false)
                }
            }.store(in: &subscriptions)
        
        updatedResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.tableView.reloadData()
                self?.isLoading.send(false)
            }.store(in: &subscriptions)
        
        addedCity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.router?.backToListView()
            }.store(in: &subscriptions)
        
        errorOccurred
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.isLoading.send(false)
                self?.alertError(errorMessage: errorMessage)
            }.store(in: &subscriptions)
    }
    
    // If updating: TableView hidden and spinner visible. Vice-versa if not.
    private func loadingUpdateViews(isLoading: Bool) {
        self.loadingSpinner.isHidden = !isLoading
        self.tableView.isHidden = isLoading
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
    func dismissView() {
        addedCity.send()
    }
    
    func displaySearchResults(with viewModel: AddEntity.ViewModel) {
        self.viewModels = viewModel.cellViewModels
        updatedResult.send()
    }
    
    func displayErrorMessage(with viewModel: AddEntity.ViewModel.Error) {
        errorOccurred.send(viewModel.message)
    }
}

extension AddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.addSelectedCity(request: AddEntity.AddCity.Request(query: viewModels[indexPath.row].name))
        isLoading.send(true)
    }
}

extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        cell.textLabel?.text = viewModels[indexPath.row].name
        
        return cell
    }
}

extension AddViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        
        if searchText.count == 0 {
            clearList()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = ""
        self.searchBar.text = ""
        self.searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        clearList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Masquer le clavier et stopper l'édition du texte
        self.searchBar.setShowsCancelButton(false, animated: true) // Masquer le bouton d'annulation
    }
    
    func clearList() {
        tableView.isHidden = true
        viewModels.removeAll()
    }
}
