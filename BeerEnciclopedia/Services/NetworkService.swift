//
//  NetworkService.swift
//  BeerEnciclopedia
//
//  Created by Afir Thes on 24.02.2023.
//

import Foundation

final class NetworkService {
    public static let shared = NetworkService()

    private init() {}

    func getBeerList(completion: @escaping ([Beer]) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true

        let session = URLSession(configuration: configuration)

        let url = URL(string: "https://api.punkapi.com/v2/beers?page=2&per_page=30")!

        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data
            else {
                print(error.debugDescription)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model: [Beer] = try decoder.decode([Beer].self,
                                                       from: data)

                completion(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }

        task.resume()
    }
}
