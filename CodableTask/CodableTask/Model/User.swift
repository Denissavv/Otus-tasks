//
//  User.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import Foundation
import CoreLocation

struct User: Decodable, Encodable {
let id: Int;
let name: String;
let userName: String;
    let address: Address;
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case address
    }
}


struct Address: Codable {
    let street: String;
    let suite: String;
    var position: CLLocation;
    
    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case position = "geo"
    }
    
    private struct Geo: Encodable, Decodable {
        let lat: String;
        let lng: String;
    }
    
    init (from decoder: Decoder) throws {
        var container = try! decoder.container(keyedBy: CodingKeys.self)
        street = try! container.decode(String.self, forKey: .street)
        suite = try! container.decode(String.self, forKey: .suite)
        let tempGeo = try! container.decode(Geo.self, forKey: .position)
        position = CLLocation(
            latitude: Double(tempGeo.lat)!,
            longitude: Double(tempGeo.lng)!
        )
    }
     func encode (to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(street,forKey:.street);
        try? container.encode(suite,forKey:.suite);
        let tempGeo = Geo(lat: String(position.coordinate.latitude), lng: String(position.coordinate.longitude))
         try? container.encode(tempGeo, forKey: .position)
    }
}
