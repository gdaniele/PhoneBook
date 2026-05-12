//
//  UserRepository.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

protocol UserRepository {
    func cachedUsers() async -> [User]?
    func fetchUsers() async throws -> [User]
}
