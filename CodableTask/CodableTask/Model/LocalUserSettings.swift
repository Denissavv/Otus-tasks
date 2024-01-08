//
//  LocalUserSettings.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import Foundation


struct LocalUserSettings: Encodable, Decodable {
    let name: String;
    let password: String;
    let isEnabled: Bool;
    
}
