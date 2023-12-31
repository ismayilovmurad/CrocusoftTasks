//
//  Character_.swift
//  RickNMorty
//
//  Created by Murad Ismayilov on 07.12.23.
//

import Foundation

struct Response: Codable {
    let info: Info
    let results: [Character_]
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
}

struct Character_: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
