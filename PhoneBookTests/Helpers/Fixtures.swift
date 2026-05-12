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
        name: String = "James Lopez",
        email: String = "james.lopez@smartholdings5661.co.uk",
        companyName: String = "Smart Holdings 5661",
        industry: String = "Telecommunications",
        phoneNumber: String = "+44 7313 493734",
        website: String = "https://www.smartholdings5661.co.uk",
        address: String = "771 Park Lane, Birmingham, UK",
        companyDescription: String = "A leading company in the telecommunications sector providing innovative and scalable solutions."
    ) -> User {
        User(name: name, email: email, companyName: companyName, industry: industry, phoneNumber: phoneNumber, website: address, address: address, companyDescription: companyDescription)
    }
}

extension APIUser {
    static func fixture(
        name: String = "James Lopez",
        email: String = "james.lopez@smartholdings5661.co.uk",
        companyName: String = "Smart Holdings 5661",
        industry: String = "Telecommunications",
        phoneNumber: String = "+44 7313 493734",
        website: String = "https://www.smartholdings5661.co.uk",
        address: String = "771 Park Lane, Birmingham, UK",
        companyDescription: String = "A leading company in the telecommunications sector providing innovative and scalable solutions."
    ) -> APIUser {
        APIUser(name: name, email: email, companyName: companyName, industry: industry, phoneNumber: phoneNumber, website: address, address: address, companyDescription: companyDescription)
    }
}
