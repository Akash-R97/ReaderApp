//
//  ArticleListViewModel.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//

import Foundation

final class ArticleListViewModel {

    // MARK: - Properties

    private let repository: ArticleRepository
    private(set) var articles: [Article] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Init

    init(repository: ArticleRepository = ArticleRepository()) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func loadArticles(forceRefresh: Bool = false) {
        if forceRefresh {
            DispatchQueue.global(qos: .userInitiated).async {
                self.repository.fetchArticlesFromAPI { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case .success(let articles):
                        self.articles = articles
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.onDataUpdated?()
                        }

                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.onError?(error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            refreshFromLocal()
        }
    }

    func refreshFromLocal() {
        articles = repository.fetchArticlesFromCache()
        onDataUpdated?()
    }

    func numberOfArticles() -> Int {
        return articles.count
    }

    func article(at index: Int) -> Article {
        return articles[index]
    }

    func search(with query: String) {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            articles = repository.fetchArticlesFromCache()
        } else {
            articles = repository.searchArticles(with: query)
        }

        DispatchQueue.main.async {
            self.onDataUpdated?()
        }
    }

    @discardableResult
    func toggleBookmark(at index: Int) -> Bool {
        let article = articles[index]
        let updatedStatus = repository.toggleBookmark(for: article)

        DispatchQueue.main.async {
            self.onDataUpdated?()
        }

        return updatedStatus
    }
}
