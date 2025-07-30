//
//  ArticleCellViewModel.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

struct ArticleCellViewModel {

    let title: String
    let author: String
    let imageUrl: URL?
    let publishedDate: String
    let isBookmarked: Bool

    init(article: Article) {
        self.title = article.title
        self.author = article.author ?? "Unknown Author"
        self.imageUrl = URL(string: article.imageUrl ?? "")
        self.publishedDate = Self.formatDate(article.publishedAt)
        self.isBookmarked = article.isBookmarked
    }

    private static func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
