//
//  User.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

struct User: Equatable, Codable {
    let company: Company
    let email: String
    let name: String
    let website: String
}

struct Address: Equatable, Codable {
    let street: String
    let city: String
    let zipcode: String
}

extension User {
    init(apiModel: APIUser) {
        self.name = apiModel.name
        self.email = apiModel.email
        self.website = apiModel.website
        self.company = apiModel.company.toDomain()
    }
}

extension Address {
    init(apiModel: APIAddress) {
        self.street = apiModel.street
        self.city = apiModel.city
        self.zipcode = apiModel.zipcode
    }
}

extension Company {
    init(apiModel: APICompany) {
        self.name = apiModel.name
        self.address = apiModel.address.toDomain()
    }
}
