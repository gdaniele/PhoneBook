import Foundation

final class UserDetailViewModel {
    private let user: User

    init(user: User) {
        self.user = user
    }
    var title: String { user.name }

    // Contact
    var phone: String { user.phoneNumber }
    var website: String { user.website }
    var address: String { user.address }

    // Company
    var companyName: String { user.companyName }
    var industry: String { user.industry }
    var companyDescription: String { user.companyDescription }
}
