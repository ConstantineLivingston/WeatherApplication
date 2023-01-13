//
//  ForecastViewController.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import UIKit
import CoreLocation
import LazyHelper

final class ForecastViewController: UIViewController {
        
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.bounces = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var locationManager = CLLocationManager()
    private let forecastPresenter: ForecastPresenter
    
    init(presenter: ForecastPresenter) {
        forecastPresenter = presenter
        super.init(nibName: nil, bundle: nil)
        forecastPresenter.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainViews()
        tableView.dataSource = self
        tableView.delegate = self
        
        locationManager.delegate = self
//        locationManager.desiredAccuracy = 100
    }
    
    private func constrainViews() {
        constrainTableView()
    }
}

// MARK: - Constrain Views

extension ForecastViewController {
    private func constrainTableView() {
        view.addConstrainedSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ForecastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastPresenter.weather?.hourlyList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier,
                                                 for: indexPath)
        var configuration = cell.dailyConfiguration()
        if let forecast = forecastPresenter.weather?.hourlyList[indexPath.row] {
            configuration.dayText = forecast.day
            configuration.tempText = "\(forecast.tempMax)/\(forecast.tempMin)"
            configuration.conditionImage = UIImage(named: forecast.icon)
        }
        cell.contentConfiguration = configuration
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ForecastHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
}


extension ForecastViewController: ForecastPresenterDelegate {
    func updateUI() {
        tableView.reloadData()
    }
}


extension ForecastViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showError(message: "Access restricted")
        case .denied:
            showError(message: "Access denied")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        if let placemark = placemarks?.last,
           let location = placemark.location {
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude
            forecastPresenter.performForecastFetch(lon: lon, lat: lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let locationAge = location.timestamp.timeIntervalSinceNow
            guard abs(locationAge) < 5.0 else { return }
            manager.stopUpdatingLocation()
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                self.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(String(describing: error))
    }
}



