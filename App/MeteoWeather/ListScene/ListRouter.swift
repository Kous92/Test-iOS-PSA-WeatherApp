//
//  ListRouter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import Foundation
import UIKit

final class ListRouter: ListRoutingLogic, ListDataPassing, AddDataDelegate {
    
    weak var view: ListViewController?
    var dataStore: ListDataStore?
    
    func showDetailView() {
        print("Navigation vers la vue détail")
    }
    
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
    
    private func navigateToDetailView(source: ListViewController, destination: DetailViewController) {
        
    }
    
    private func navigateToAddView(source: ListViewController, destination: AddViewController) {
        source.navigationController?.present(destination, animated: true)
    }
    
    // Delegate method
    func updateCityList() {
        updateFromAddView()
    }
    
    func updateFromAddView() {
        view?.updateCityList()
    }
}
