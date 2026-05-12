//
//  CachingUserRepository.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

struct CachingUserRepository: UserRepository {    
    let cache: UserCache
    let apiClient: APIClient
    
    func cachedUsers() async -> [User]? {
        try? await cache.load()
    }
    
    func fetchUsers() async throws -> [User] {
        let apiUsers = try await apiClient.fetchUsers()
        let users = apiUsers.map { $0.toDomain() }
        try? await cache.save(users)
        return users
    }
}
