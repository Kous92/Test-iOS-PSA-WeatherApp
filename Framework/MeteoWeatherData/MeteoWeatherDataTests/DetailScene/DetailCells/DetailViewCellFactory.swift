//
//  DetailViewCellFactory.swift
//  MeteoWeather
//
//  Created by Koussaïla Ben Mamar on 14/03/2023.
//

import Foundation
import UIKit

final class DetailViewCellFactory {
    static func createCell(with detailType: DetailStatsType, viewModel: DetailEntity.WeatherDetails.ViewModel, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        switch detailType {
            case .wind:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: WindTableViewCell.identifier, for: indexPath) as? WindTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getWindViewModel())
                return cell
            case .temperature:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.identifier, for: indexPath) as? TemperatureTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getTemperatureViewModel())
                return cell
            case .rain:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RainSnowTableViewCell.identifier, for: indexPath) as? RainSnowTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getRainViewModel())
                return cell
            case .snow:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RainSnowTableViewCell.identifier, for: indexPath) as? RainSnowTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getSnowViewModel())
                return cell
            case .sunset:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SunsetSunriseTableViewCell.identifier, for: indexPath) as? SunsetSunriseTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getSunsetSunriseViewModel())
                return cell
            case .pressure:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherWeatherStatsTableViewCell.identifier, for: indexPath) as? OtherWeatherStatsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getPressureViewModel())
                return cell
            case .humidity:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherWeatherStatsTableViewCell.identifier, for: indexPath) as? OtherWeatherStatsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getHumidityViewModel())
                return cell
            case .cloudiness:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherWeatherStatsTableViewCell.identifier, for: indexPath) as? OtherWeatherStatsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: viewModel.getVisibilityViewModel())
                return cell
        }
    }
}
