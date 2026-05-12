import UIKit

// UserListViewController.swift
import UIKit

final class UserListViewController: UITableViewController {
    private let viewModel: UserListViewModel
    private var users: [User] = []

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl = refresh

        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }

        Task { await viewModel.load() }
    }

    @objc private func handleRefresh() {
        Task {
            await viewModel.load()
            refreshControl?.endRefreshing()
        }
    }

    private func render(_ state: UserListViewModel.State) {
        switch state {
        case .idle:
            break
        case .loading:
            if users.isEmpty {
                navigationItem.titleView = makeSpinner()
            }
        case .loaded(let users):
            navigationItem.titleView = nil
            self.users = users
            tableView.reloadData()
        case .failed(let error):
            navigationItem.titleView = nil
            presentErrorAlert(error)
        }
    }

    private func makeSpinner() -> UIActivityIndicatorView {
        let s = UIActivityIndicatorView(style: .medium)
        s.startAnimating()
        return s
    }

    private func presentErrorAlert(_ error: Error) {
        let alert = UIAlertController(
            title: "Couldn't load users",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            Task { await self?.viewModel.load() }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - DataSource
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
        cell.configure(with: users[indexPath.row])
        return cell
    }

    // MARK: - Delegate (navigation)
    override func tableView(_ tv: UITableView, didSelectRowAt indexPath: IndexPath) {
        tv.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        let detailVM = UserDetailViewModel(user: user)
        let detailVC = UserDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
