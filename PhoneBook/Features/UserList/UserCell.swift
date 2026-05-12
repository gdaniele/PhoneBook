import UIKit

// Displays name, email, company name
import UIKit

final class UserCell: UITableViewCell {
    static let reuseIdentifier = "UserCell"

    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let companyLabel = UILabel()
    private let stack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        companyLabel.text = user.companyName
    }

    private func setupViews() {
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true

        emailLabel.font = .preferredFont(forTextStyle: .subheadline)
        emailLabel.textColor = .secondaryLabel
        emailLabel.adjustsFontForContentSizeCategory = true

        companyLabel.font = .preferredFont(forTextStyle: .footnote)
        companyLabel.textColor = .tertiaryLabel
        companyLabel.adjustsFontForContentSizeCategory = true

        stack.axis = .vertical
        stack.spacing = 2
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(emailLabel)
        stack.addArrangedSubview(companyLabel)

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])

        accessoryType = .disclosureIndicator
    }
}
