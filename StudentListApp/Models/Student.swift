//
//  Student.swift
//  StudentListApp
//
//  Created by Seteven on 11/01/25.
//

import Foundation

struct Student: Identifiable {
    let id: String
    let name: String
    let profilePicture: String
    let address: String
}

struct RandomUserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let id: Id?
    let name: Name
    let picture: Picture?
    let location: Location?
}

struct Id: Codable {
    let value: String?
}
struct Name: Codable {
    let first: String
    let last: String
}
struct Picture: Codable {
    let large: String
}
struct Location: Codable {
    let city: String
    let country: String
}
