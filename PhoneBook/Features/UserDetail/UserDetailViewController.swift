import UIKit

// Displays phone, website, full address, and full company details
final class UserDetailViewController: UITableViewController {
    private let viewModel: UserDetailViewModel

    private enum Section: Int, CaseIterable {
        case contact, company
        var title: String {
            switch self {
            case .contact: return "Contact"
            case .company: return "Company"
            }
        }
    }

    private struct Row {
        let label: String
        let value: String
    }

    private lazy var sections: [[Row]] = [
        [
            Row(label: "Phone", value: viewModel.phone),
            Row(label: "Website", value: viewModel.website),
            Row(label: "Address", value: viewModel.address),
        ],
        [
            Row(label: "Name", value: viewModel.companyName),
            Row(label: "Industry", value: viewModel.industry),
            Row(label: "Description", value: viewModel.companyDescription),
        ],
    ]

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }

    // MARK: - DataSource
    override func numberOfSections(in tableView: UITableView) -> Int { sections.count }

    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    override func tableView(_ tv: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section(rawValue: section)?.title
    }

    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = sections[indexPath.section][indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = row.label
        config.textProperties.font = .preferredFont(forTextStyle: .footnote)
        config.textProperties.color = .secondaryLabel
        
        config.secondaryText = row.value
        config.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        config.secondaryTextProperties.color = .label
        config.secondaryTextProperties.numberOfLines = 0
        
        cell.contentConfiguration = config
        cell.selectionStyle = .none

        return cell
    }
}
