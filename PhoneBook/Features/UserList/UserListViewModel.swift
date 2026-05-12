import Foundation

@MainActor
final class UserListViewModel {
    enum State {
        case idle
        case loading
        case loaded([User])
        case failed(Error)
    }

    private let repository: UserRepository

    private(set) var state: State = .idle {
        didSet { onStateChange?(state) }
    }

    var onStateChange: ((State) -> Void)?

    init(repository: UserRepository) {
        self.repository = repository
    }

    func load() async {
        // Show cached immediately, if we have something
        if let cached = await repository.cachedUsers(), !cached.isEmpty {
            state = .loaded(cached)
        } else {
            state = .loading
        }

        // Next, fetch from network
        do {
            let fresh = try await repository.fetchUsers()
            state = .loaded(fresh)
        } catch {
            // If we had cached data, keep showing it; only fail if we had nothing
            if case .loaded = state {
                // ToDo - show non-blocking refresh-failed signal here
                // Deliberate product choice.. no need to fail if we have data in cache
            } else {
                state = .failed(error)
            }
        }
    }
}
