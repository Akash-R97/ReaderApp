//
//  ArticleListViewController.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//

import UIKit

final class ArticleListViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    private let emptyStateLabel = UILabel()

    private let viewModel = ArticleListViewModel()
    private var didSetSearchController = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadArticles(forceRefresh: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !didSetSearchController {
            navigationItem.searchController = searchController
            definesPresentationContext = true
            didSetSearchController = true
        }

        // Refresh local copy to reflect any bookmark changes
        viewModel.refreshFromLocal()
    }

    private func setupUI() {
        title = "Top Headlines"
        view.backgroundColor = .systemBackground

        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.contentInset.bottom = 16
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search articles..."

        emptyStateLabel.text = "No articles found."
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.font = .systemFont(ofSize: 18)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.isHidden = true
        view.addSubview(emptyStateLabel)

        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }

            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.showEmptyStateIfNeeded()
        }

        viewModel.onError = { [weak self] error in
            self?.refreshControl.endRefreshing()
            self?.showToast(message: error)
        }
    }

    @objc private func handleRefresh() {
        viewModel.loadArticles(forceRefresh: true)
    }

    private func showEmptyStateIfNeeded() {
        let isEmpty = viewModel.numberOfArticles() == 0
        emptyStateLabel.isHidden = !isEmpty

        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = isEmpty ? 0 : 1
        }
    }

    private func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            alert.dismiss(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension ArticleListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }

        let article = viewModel.article(at: indexPath.row)
        let cellVM = ArticleCellViewModel(article: article)
        cell.configure(with: cellVM)

        cell.onBookmarkTapped = { [weak self] in
            guard let self = self else { return }
            let isBookmarked = self.viewModel.toggleBookmark(at: indexPath.row)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.showToast(message: isBookmarked ? "Bookmarked" : "Removed from bookmarks")
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.article(at: indexPath.row)
        let detailVC = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension ArticleListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.search(with: query)
    }
}
