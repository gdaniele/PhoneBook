import Foundation

// AppDependencies.swift
struct AppDependencies {
    let userRepository: UserRepository

    // Staticly create instances of all dependencies to inject
    static func live() -> AppDependencies {
        let api = HTTPAPIClient(session: .shared)

        let cacheURL = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("users.json")
        let cache = FileUserCache(fileURL: cacheURL)

        let repository = CachingUserRepository(apiClient: api, cache: cache)

        return AppDependencies(userRepository: repository)
    }
}
