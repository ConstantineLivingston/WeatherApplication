//
//  ForecastPresenter.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import Foundation

protocol ForecastPresenterProtocol {
    var delegate: ForecastPresenterDelegate? { get set }
    func performForecastFetch(lon: Double, lat: Double)
}

protocol ForecastPresenterDelegate: AnyObject {
    func updateUI() 
}

final class ForecastPresenter: ForecastPresenterProtocol {
    typealias HourlyForecast = WeatherAPI.Types.Response.HourlyForecast
    typealias APIError = WeatherAPI.Types.APIError
    
    private let forecastAPIClient: WeatherAPI.Client
    weak var delegate: ForecastPresenterDelegate?
    
    var weather: WeatherModel?
    
    init(forecastAPIClient: WeatherAPI.Client,
         delegate: ForecastPresenterDelegate? = nil) {
        self.forecastAPIClient = forecastAPIClient
        self.delegate = delegate
    }
    
    func performForecastFetch(lon: Double, lat: Double) {
        let stringLon = lon.reducedAccuracy
        let stringLat = lat.reducedAccuracy
        
        forecastAPIClient.fetchData(from: .forecast(lat: stringLat, lon: stringLon)) {
            (result: Result<HourlyForecast, APIError>) in
            switch result {
            case .success(let success):
                self.weather = WeatherModel(city: success.city.name)
                let list = success.list.sorted { $0.date < $1.date }
                self.weather?.hourlyList = list
                    .filter { $0.date.isIn24HourRange }
                    .map {
                        Forecast(date: $0.date,
                                 tempMin: $0.mainInfo.tempMin.RoundedToClosestInt,
                                 tempMax: $0.mainInfo.tempMax.RoundedToClosestInt,
                                 humidity: $0.mainInfo.humidity,
                                 icon: $0.weather[0].icon,
                                 wind: Wind(speed: $0.wind.speed.RoundedToClosestInt,
                                            degree: $0.wind.degree))
                    }
                
                var components: [DateComponents] = []
                self.weather?.dailyList = list
                    .filter {
                        let dayComponent = $0.date.get(components: .day)
                        guard !components.contains(dayComponent) else { return false }
                        components.append(dayComponent)
                        return true
                    }
                    .map {
                        Forecast(date: $0.date,
                                 tempMin: $0.mainInfo.tempMin.RoundedToClosestInt,
                                 tempMax: $0.mainInfo.tempMax.RoundedToClosestInt,
                                 humidity: $0.mainInfo.humidity,
                                 icon: $0.weather[0].icon,
                                 wind: Wind(speed: $0.wind.speed.RoundedToClosestInt,
                                            degree: $0.wind.degree))
                    }
                    
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
