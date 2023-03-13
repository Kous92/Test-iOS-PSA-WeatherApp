//
//  AddRouter.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 13/03/2023.
//

import Foundation

final class AddRouter: AddRoutingLogic {
    weak var addDelegate: AddDataDelegate?
    weak var addViewController: AddViewController?
    
    func backToListView() {
        addDelegate?.updateCityList()
        
        guard let addViewController else {
            fatalError("Aucune référence vers la vue pour ajouter des villes !")
        }
        
        dismissView(source: addViewController)
    }
    
    func dismissView(source: AddViewController) {
        addViewController?.dismiss(animated: true)
    }
}
