import Foundation

struct FileUserCache: UserCache {
    let fileURL: URL

    func load() async throws -> [User]? {
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("Cache fail")
                return nil
            }
            let data = try Data(contentsOf: fileURL)
            let users = try JSONDecoder().decode([User].self, from: data)
            print("Cache success: \(users.count) users from \(fileURL.path)")
            return users
        }

        func save(_ users: [User]) async throws {
            let data = try JSONEncoder().encode(users)
            try data.write(to: fileURL, options: .atomic)
            print("Cache write success \(users.count) users to \(fileURL.path)")
        }
}
