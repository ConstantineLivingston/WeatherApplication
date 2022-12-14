//
//  WeatherAPIClient.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 07.12.2022.
//

import Foundation

extension WeatherAPI {
    class Client {
        static let shared = Client()
        
        func fetchData<T: Decodable>(from endpoint: Types.Endpoint,
                                     withCompletion completion:
                                     @escaping (Result<T, Types.APIError>) -> Void) {
            let dataTask = URLSession.shared
                .dataTask(with: endpoint.url) { data, response, error in
                    guard error == nil else {
                        print("Fetching error: ", String(describing: error!))
                        completion(.failure(.generic(reason: error!.localizedDescription)))
                        return
                    }
                    
                    guard let data = data else { return }
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Decoding Error: ", String(describing: error))
                        completion(.failure(.generic(reason: "Could not decode data: \(error.localizedDescription)")))
                    }
                }
            dataTask.resume()
        }
    }
}
