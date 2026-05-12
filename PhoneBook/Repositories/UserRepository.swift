import Foundation

protocol UserRepository {
    func cachedUsers() async -> [User]?
    func fetchUsers() async throws -> [User]
}
