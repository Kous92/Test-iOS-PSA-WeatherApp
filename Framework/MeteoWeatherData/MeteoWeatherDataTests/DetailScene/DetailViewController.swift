//
//  DetailViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // Clean Swift components
    private var interactor: DetailBusinessLogic?
    var router: DetailDataPassing?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getPassedCityWeather()
    }
    
    // Mise en place des composants de Clean Swift
    private func setup() {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.view = self
        router.view = self
        router.dataStore = interactor
    }
}

extension DetailViewController: DetailDisplayLogic {
    func displayDetails(with viewModel: DetailEntity.WeatherDetails.ViewModel) {
        nameLabel.text = viewModel.name
        tempLabel.text = viewModel.temperature
        iconImageView.image = UIImage(named: viewModel.weatherIcon)
        weatherDescription.text = viewModel.weatherDescription
    }
}
