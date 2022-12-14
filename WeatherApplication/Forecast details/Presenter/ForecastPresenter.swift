//
//  ForecastPresenter.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import Foundation

protocol ForecastPresenterDelegate: AnyObject {
    func updateUI() 
}

final class ForecastPresenter {
    typealias HourlyForecast = WeatherAPI.Types.Response.HourlyForecast
    typealias APIError = WeatherAPI.Types.APIError
    
    private let forecastAPIClient: WeatherAPI.Client
    weak var delegate: ForecastPresenterDelegate?
    
    var forecast: HourlyForecast?
    
    init(forecastAPIClient: WeatherAPI.Client,
         delegate: ForecastPresenterDelegate? = nil) {
        self.forecastAPIClient = forecastAPIClient
        self.delegate = delegate
    }
    
    func performForecastFetch(lon: Double, lat: Double) {
        let stringLon = String(format: "%.3f", lon)
        let stringLat = String(format: "%.3f", lat)
        forecastAPIClient.fetchData(from: .forecast(lat: stringLat, lon: stringLon)) {
            (result: Result<HourlyForecast, APIError>) in
            switch result {
            case .success(let success):
                self.forecast = success
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
