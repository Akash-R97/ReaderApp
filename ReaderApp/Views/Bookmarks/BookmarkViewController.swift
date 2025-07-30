//
//  BookmarkViewController.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
//

import UIKit

final class BookmarkViewController: UIViewController {

    private let tableView = UITableView()
    private let viewModel = BookmarkViewModel()
    private let emptyStateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadBookmarks() // Refresh bookmark list on view appear
    }

    private func setupUI() {
        title = "Bookmarks"
        view.backgroundColor = .systemBackground

        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        emptyStateLabel.text = "No bookmarks yet."
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
            self?.tableView.reloadData()
            self?.showEmptyStateIfNeeded()
        }
    }

    private func showEmptyStateIfNeeded() {
        let isEmpty = viewModel.numberOfArticles() == 0
        emptyStateLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
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

extension BookmarkViewController: UITableViewDataSource {

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

extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.article(at: indexPath.row)
        let detailVC = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
