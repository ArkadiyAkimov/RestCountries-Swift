//
//  Countries.swift
//  exam001Countries
//
//  Created by Arkadiy Akimov on 16/08/2022.
//

import Foundation

struct Country: Decodable {
    let alpha3Code: String?
    let name: String?
    let nativeName: String?
    let area: Double?
    let borders: [String]?
}

