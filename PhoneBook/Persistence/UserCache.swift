import Foundation

protocol UserCache {
    func load() async throws -> [User]?
    func save(_ users: [User]) async throws
}
