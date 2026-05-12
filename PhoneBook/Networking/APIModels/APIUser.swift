//
//  APIUser.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

struct APIUser: Equatable, Codable {
    var id: String { email }
    let name: String
    let email: String
    let companyName: String
    let industry: String
    let phoneNumber: String
    let website: String
    let address: String
    let companyDescription: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case companyName = "Company Name"
        case industry = "Industry"
        case phoneNumber = "Phone Number"
        case website = "Website"
        case address = "Address"
        case companyDescription = "Company Description"
    }
}

extension APIUser {
    func toDomain() -> User {
        User(name: name, email: email, companyName: companyName, industry: industry, phoneNumber: phoneNumber, website: website, address: address, companyDescription: companyDescription)
    }
}
