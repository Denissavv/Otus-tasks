//
//  UrlSessionNetworkLayer.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import Foundation



enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol URLRequestConvertible {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var urlQuery: [String: String] { get }
    var headers: [String: String] { get }
    var body: [String: Any] { get }
    var method: HTTPMethod { get }
}


extension URLRequestConvertible {
    var scheme: String { "https" }
    var host: String { "jsonplaceholder.typicode.com" }
    var urlQuery: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: [String: Any] { [:] }

    func asRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        if !urlQuery.isEmpty {
            let queryItems = urlQuery.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if !body.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return request
    }

}

enum UserAPI: URLRequestConvertible {
    case getUsers

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
}



struct UrlSessinNetworkLayer {
    func getUsers(callback: @escaping(Result<[User], NetworkError>) -> Void) {
        do {
            let request = try UserAPI.getUsers.asRequest()
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    return callback(.failure(.invalidRequest))
                }

                guard let data = data else {
                    return callback(.failure(.invalidRequest))
                }

                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    callback(.success(users))
                    print(users)
                } catch {
                    callback(.failure(.invalidRequest))
                }
            }.resume()
        } catch {
            callback(.failure(.invalidURL))
        }
    }
}


