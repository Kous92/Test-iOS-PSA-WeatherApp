//
//  ListRouter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import UIKit

final class ListRouter: ListRoutingLogic, ListDataPassing {
    
    weak var view: ListViewController?
    var dataStore: ListDataStore?
    
    func showAddView() {
        guard let addViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as? AddViewController,
            let listViewController = view,
            let addRouter = addViewController.router as? AddRouter
        else {
            fatalError("La vue pour ajouter des villes n'est pas disponible !")
        }
        
        addRouter.addDelegate = self
        navigateToAddView(source: listViewController, destination: addViewController)
    }
    
    func showDetailView(at indexPath: IndexPath) {
        print("Navigation vers la vue détail à l'index \(indexPath.row)")
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController,
              let dataStore,
              var detailDataStore = detailViewController.router?.dataStore,
              let newsListViewController = view
        else {
            fatalError("La vue détail n'est pas disponible !")
        }
        
        passDataToDetailView(source: dataStore, destination: &detailDataStore, at: indexPath)
        navigateToDetailView(source: newsListViewController, destination: detailViewController)
    }
    
    func passDataToDetailView(source: ListDataStore, destination: inout DetailDataStore, at indexPath: IndexPath) {
        destination.cityWeather = source.cities[indexPath.row]
    }
    
    private func navigateToDetailView(source: ListViewController, destination: DetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func navigateToAddView(source: ListViewController, destination: AddViewController) {
        source.navigationController?.present(destination, animated: true)
    }
}

extension ListRouter: AddDataDelegate {
    func updateCityList() {
        updateFromAddView()
    }
    
    func updateFromAddView() {
        view?.updateCityList()
    }
}
