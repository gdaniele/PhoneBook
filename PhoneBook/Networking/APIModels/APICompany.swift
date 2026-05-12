//
//  APICompany.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

struct APICompany: Equatable, Codable {
    let name: String
    let address: APIAddress
}

struct APIAddress: Equatable, Codable {
    let street: String
    let city: String
    let zipcode: String
}

extension APIAddress {
    func toDomain() -> Address {
        Address(street: street, city: city, zipcode: zipcode)
    }
}

extension APICompany {
    func toDomain() -> Company {
        Company(name: name, address: address.toDomain())
    }
}
