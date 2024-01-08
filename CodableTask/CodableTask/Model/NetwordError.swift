//
//  NetwordError.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import Foundation


enum NetworkError: Error {
    case invalidMimeType
    case invalidStatusCode
    case invalidRequest
    case serverFailed
    case unknown
    case emptyData
    case invalidURL
}
