//
//  DetailViewController.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 12/03/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    private var viewModel: DetailEntity.WeatherDetails.ViewModel?
    private var cellConfigurations = [DetailStatsType]()
    
    // Clean Swift components
    private var interactor: DetailBusinessLogic?
    var router: DetailDataPassing?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
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
        self.navigationController?.navigationBar.tintColor = .label
        setTableView()
        interactor?.getPassedCityWeather()
    }
    
    // Setting Clean Swift components
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

extension DetailViewController {
    func setTableView() {
        tableView.dataSource = self
        tableView.register(TemperatureTableViewCell.nib, forCellReuseIdentifier: TemperatureTableViewCell.identifier)
        tableView.register(WindTableViewCell.nib, forCellReuseIdentifier: WindTableViewCell.identifier)
        tableView.register(RainSnowTableViewCell.nib, forCellReuseIdentifier: RainSnowTableViewCell.identifier)
        tableView.register(SunsetSunriseTableViewCell.nib, forCellReuseIdentifier: SunsetSunriseTableViewCell.identifier)
        tableView.register(OtherWeatherStatsTableViewCell.nib, forCellReuseIdentifier: OtherWeatherStatsTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 85
    }
    
    func setTopView() {
        guard let viewModel else {
            return
        }
        
        nameLabel.text = viewModel.name + ", " + viewModel.country
        tempLabel.text = viewModel.temperature
        iconImageView.image = UIImage(named: viewModel.weatherIcon)
        weatherDescription.text = viewModel.weatherDescription
        lastUpdateLabel.text = viewModel.lastUpdateTime
        
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellConfigurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel, let cell = DetailViewCellFactory.createCell(with: cellConfigurations[indexPath.row], viewModel: viewModel, tableView: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        return cell
    }
}

extension DetailViewController: DetailDisplayLogic {
    func displayDetails(with viewModel: DetailEntity.WeatherDetails.ViewModel) {
        self.viewModel = viewModel
        self.cellConfigurations = viewModel.getCellConfigurations()
        setTopView()
    }
}
