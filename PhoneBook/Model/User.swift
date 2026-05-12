import Foundation

struct User: Equatable, Codable {
    var id: String { email }
    let name: String
    let email: String
    let companyName: String
    let industry: String
    let phoneNumber: String
    let website: String
    let address: String
    let companyDescription: String
}

extension User {
    init(apiModel: APIUser) {
        self.name = apiModel.name
        self.email = apiModel.email
        self.companyName = apiModel.companyName
        self.industry = apiModel.industry
        self.phoneNumber = apiModel.phoneNumber
        self.website = apiModel.website
        self.address = apiModel.address
        self.companyDescription = apiModel.companyDescription
    }
}

