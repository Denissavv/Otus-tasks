//
//  RestApiClient.swift
//  NetworkDemo
//
//  Created by igor.sorokin on 12.12.2023.
//

import Foundation


final class RestApiClient {
    private let session: URLSession = .shared

    func performRequest(_ requestConverible: URLRequestConvertible, completion: @escaping (Result<Data, Error>) -> Void) {
        let request: URLRequest

        do {
            request = try requestConverible.asRequest()
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let error = self.validate(response: response) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyData))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }

    private func validate(response: URLResponse?) -> Error? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkError.unknown
        }

        guard httpResponse.mimeType == "application/json" else {
            return NetworkError.invalidMimeType
        }

        switch httpResponse.statusCode {
        case 100..<200, 300..<400:
            return NetworkError.invalidStatusCode
        case 400..<500:
            return NetworkError.invalidRequest
        case 500..<600:
            return NetworkError.serverFailed
        default:
            break
        }

        return nil
    }
}
