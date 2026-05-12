//
//  APIUser.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

struct APIUser: Equatable, Codable {
    let company: APICompany
    let email: String
    let name: String
    let website: String
}

extension APIUser {
    func toDomain() -> User {
        User(company: company.toDomain(), email: email, name: name, website: website)
    }
}
