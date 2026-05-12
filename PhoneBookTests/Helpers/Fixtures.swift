//
//  Fixtures.swift
//  PhoneBookTests
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Testing
import Foundation
@testable import PhoneBook

extension User {
    static func fixture(
        email: String = "test@example.com",
        name: String = "Test User",
        company: Company = .fixture(),
        website: String = "http://example.com"
    ) -> User {
        User(company: company, email: email, name: name, website: website)
    }
}

extension Company {
    static func fixture(
        name: String = "Schmoop",
        address: Address = .fixture()
    ) -> Company {
        Company(name: name, address: address)
    }
}

extension Address {
    static func fixture(
        street: String = "123 Fake St",
        city: String = "Springfield",
        zipcode: String = "12345"
    ) -> Address {
        Address(street: street, city: city, zipcode: zipcode)
    }
}

extension APIUser {
    static func fixture(
        email: String = "test@example.com",
        name: String = "Test User",
        company: APICompany = .fixture(),
        website: String = "http://example.com"
    ) -> APIUser {
        APIUser(company: company, email: email, name: name, website: website)
    }
}

extension APICompany {
    static func fixture(
        name: String = "Schmoop",
        address: APIAddress = .fixture()
    ) -> APICompany {
        APICompany(name: name, address: address)
    }
}

extension APIAddress {
    static func fixture(
        street: String = "123 Fake St",
        city: String = "Springfield",
        zipcode: String = "12345"
    ) -> APIAddress {
        APIAddress(street: street, city: city, zipcode: zipcode)
    }
}
