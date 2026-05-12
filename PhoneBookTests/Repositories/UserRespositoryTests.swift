import Testing
import Foundation
@testable import PhoneBook


final class InMemoryUserCache: UserCache {
    private(set) var storage: [User]?
    
    func load() async throws -> [User]? {
        return storage
    }
    
    func save(_ users: [User]) async throws {
        self.storage = users
    }
        
    init(users: [User]? = nil) {
        self.storage = users
    }
}

struct StubAPIClient: APIClient {
    let result: Result<[APIUser], Error>

    func fetchUsers() async throws -> [APIUser] {
        try result.get()  // .success → returns value; .failure → throws error
    }
}

struct CachingUserRepositoryTests {
    
    // MARK: - cachedUsers()
    @Test("Returns nil when cache is empty")
    func cachcedUsers_returnsNil_whenCacheIsEmpty() async {
        let (sut, _) = makeSUT()
        #expect(await sut.cachedUsers() == nil)
    }
    
    @Test("Returns cached users when present")
    func cachedUsers_returnsUsers_whenCachePopulated() async {
        let users = [User.fixture(name: "Jack"), User.fixture(name: "Jill")]
        let (sut, _) = makeSUT(cachedUsers: users)
        #expect(await sut.cachedUsers() == users)

    }
    
    // MARK: - fetchUsers()
    
    @Test("Maps API Model to Domain model")
    func fetchUsers_mapsAPIModelToDomainModel() async throws {
        let apiUsers = [APIUser.fixture(name: "Martha")]
        let (sut, cache) = makeSUT(result: .success(apiUsers))
        
        _ = try await sut.fetchUsers()

        #expect(cache.storage?.first?.name == "Martha")
    }
    
    
    @Test("Saves fetched value to cache on success")
    func fetchUsers_savesFetchedValueToCache_onSuccess() async throws {
        let users = [User.fixture(name: "George")]
        let apiUsers = [APIUser.fixture(name: "George")]

        let (sut, cache) = makeSUT(result: .success(apiUsers))
        
        _ = try await sut.fetchUsers()
        
        #expect(cache.storage == users)
    }
    
    
    @Test("Returns cached value on API failure")
    func fetchUsers_returnsCachedValueOnAPIFailure() async throws {
        let users = [User.fixture(name: "George")]
        let (sut, cache) = makeSUT(result: .failure(URLError(.notConnectedToInternet)),
                                   cachedUsers: users)
        
        await #expect(throws: URLError.self) {
            _ = try await sut.fetchUsers()
        }
        
        #expect(cache.storage == users)
    }

    // MARK: - Helpers
    
    private func makeSUT(
        result: Result<[APIUser], Error> = .success([]),
        cachedUsers: [User]? = nil
    ) -> (sut: CachingUserRepository, cache: InMemoryUserCache) {
        let client = StubAPIClient(result: result)
        let cache = InMemoryUserCache(users: cachedUsers)
        let sut = CachingUserRepository(apiClient: client, cache: cache)
        return (sut, cache)
    }
}
