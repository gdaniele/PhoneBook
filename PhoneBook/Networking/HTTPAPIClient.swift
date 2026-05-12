import Foundation

struct APIUserListResponse: Decodable {
    let users: [APIUser]

    enum CodingKeys: String, CodingKey {
        case users = "Company-List"
    }
}

struct HTTPAPIClient: APIClient {
    let session: URLSession
    let url: URL  // full URL, not a baseURL

    init(
        session: URLSession = .shared,
        url: URL = URL(string: "https://mobile-code-test.s3.eu-west-1.amazonaws.com/full_list.json")!
    ) {
        self.session = session
        self.url = url
    }


    func fetchUsers() async throws -> [APIUser] {
        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.httpError(statusCode: http.statusCode)
        }
        do {
            let payload = try JSONDecoder().decode(APIUserListResponse.self, from: data)
            return payload.users
        } catch {
            throw APIError.decodingFailed(underlying: error)
        }
    }
}
