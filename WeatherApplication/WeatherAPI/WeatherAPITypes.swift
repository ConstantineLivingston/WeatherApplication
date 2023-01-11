//
//  WeatherAPI.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import Foundation

enum WeatherAPI {
    enum Types {
        
        enum Response {
            
            struct HourlyForecast: Decodable {
                let list: [Hourly]
                let city: City
                
                struct City: Decodable {
                    let name: String
                }
                
                struct Hourly: Decodable {
                    let date: Date
                    let mainInfo: MainInfo
                    let weather: [Weather]
                    let wind: Wind
                    
                    enum CodingKeys: String, CodingKey {
                        case date = "dt"
                        case mainInfo = "main"
                        case weather
                        case wind
                    }
                    
                    struct Wind: Decodable {
                        let speed: Double
                        let degree: Int
                        
                        enum CodingKeys: String, CodingKey {
                            case speed
                            case degree = "deg"
                        }
                    }
                    
                    struct Weather: Decodable {
                        let icon: String
                    }
                    
                    struct MainInfo: Decodable {
                        let tempMin: Double
                        let tempMax: Double
                        let humidity: Int
                        
                        enum CodingKeys: String, CodingKey {
                            case tempMin = "temp_min"
                            case tempMax = "temp_max"
                            case humidity
                        }
                    }
                }
                
            }
        }
        
        enum APIError: LocalizedError {
            case generic(reason: String)
            case `internal`(reason: String)
            
            var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "Internal Error: \(reason)"
                }
            }
        }
        
        enum Endpoint {
            case forecast(lat: String, lon: String)
            
            var url: URL {
                var components = URLComponents()
                components.scheme = "https"
                components.host = "api.openweathermap.org"
                
                switch self {
                case let .forecast(lat, lon):
                    components.path = "/data/2.5/forecast"
                    components.queryItems = [
                        URLQueryItem(name: "lat", value: lat),
                        URLQueryItem(name: "lon", value: lon),
                        URLQueryItem(name: "units", value: "metric"),
                        URLQueryItem(name: "appid", value: "469a19ec73f3cd3d34b9a7bda4f1e492"),
                    ]
                }
                return components.url!
            }
        }
        
    }
}
