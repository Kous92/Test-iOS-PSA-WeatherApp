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

protocol AddDataDelegate: AnyObject {
    func updateData()
}

class ListViewController: UIViewController, AddDataDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var interactor: ListBusinessLogic?
    private var router: (ListRoutingLogic & ListDataPassing)?
    private var viewModels = [ListEntity.ViewModel.CityViewModel]()
    
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
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.view = self
        router.view = self
        router.dataStore = interactor
    }
    
    private func setViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        updateData()
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        print("AddCityVC")
        
        router?.showAddView()
        
        /*
        guard let addViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {
            fatalError("La vue pour ajouter des villes n'est pas disponible !")
        }
        
        addViewController.updateDelegate = self
        self.navigationController?.present(addViewController, animated: true)
         */
    }
    
    func updateData() {
        print("Update list")
        interactor?.fetchCities()
    }
}

extension ListViewController {
    private func alertError(errorMessage: String) {
        let alert = UIAlertController(title: "Erreur", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListViewController: ListDisplayLogic {
    func completeDeletion(at indexPath: IndexPath) {
        viewModels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func updateCityList(with viewModel: ListEntity.ViewModel) {
        self.viewModels = viewModel.cellViewModels
        tableView.reloadData()
    }
    
    func displayErrorMessage(with viewModel: ListEntity.ViewModel.Error) {
        alertError(errorMessage: viewModel.message)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ouvrir la vue détail pour afficher toute la météo.")
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("La vue détail n'est pas disponible !")
        }
        
        // detailViewController.cityWeather = cities[indexPath.row]
        // self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? CityWeatherTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    // À faire: adapter cette fonctionnalité à l'architecture.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cityName = viewModels[indexPath.row].name
            interactor?.deleteCity(request: ListEntity.DeleteCity.Request(name: cityName, index: indexPath))
            
            /*
            let city = cities[indexPath.row]
            repository.deleteCity(with: city)
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
             */
        }
    }
}
