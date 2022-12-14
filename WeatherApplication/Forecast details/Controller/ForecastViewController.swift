//
//  ForecastViewController.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import UIKit
import CoreLocation

final class ForecastViewController: UIViewController {
    
    private let forecastPresenter = ForecastPresenter(forecastAPIClient: WeatherAPI.Client.shared)
    private let tableView = UITableView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastPresenter.delegate = self
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        locationManager.delegate = self

    }
    
    
    
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastPresenter.forecast?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let forecast = forecastPresenter.forecast?.list[indexPath.row]
        cell.textLabel?.text = forecast?.date.formatted()
        cell.imageView?.image = UIImage(named: forecast!.weather[0].icon)
        return cell
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
            manager.requestLocation()
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
