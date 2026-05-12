//
//  UserCache.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

protocol UserCache {
    func load() async throws -> [User]?
    func save(_ users: [User]) async throws
}
