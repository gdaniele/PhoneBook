import Foundation

struct CachingUserRepository: UserRepository {
    let apiClient: APIClient
    let cache: UserCache
    
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
