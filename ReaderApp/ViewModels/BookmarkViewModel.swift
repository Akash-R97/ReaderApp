//
//  BookmarkViewModel.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

final class BookmarkViewModel {

    private let repository: ArticleRepository
    private(set) var bookmarkedArticles: [Article] = []
    var onDataUpdated: (() -> Void)?

    init(repository: ArticleRepository = ArticleRepository()) {
        self.repository = repository
    }

    func loadBookmarks() {
        bookmarkedArticles = repository.fetchBookmarkedArticles()
        onDataUpdated?()
    }

    @discardableResult
    func toggleBookmark(at index: Int) -> Bool {
        let article = bookmarkedArticles[index]
        let status = repository.toggleBookmark(for: article)
        loadBookmarks()
        return status
    }

    func numberOfArticles() -> Int {
        return bookmarkedArticles.count
    }

    func article(at index: Int) -> Article {
        return bookmarkedArticles[index]
    }
}
