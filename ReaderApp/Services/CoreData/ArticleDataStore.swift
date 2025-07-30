//
//  ArticleDataStore.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//

import Foundation
import CoreData

final class ArticleDataStore {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    private func parseDate(from string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: string) {
            return date
        } else {
            formatter.formatOptions = [.withInternetDateTime]
            return formatter.date(from: string)
        }
    }

    func saveArticles(_ articles: [ArticleDTO]) {
        for dto in articles {
            guard !dto.title.trimmingCharacters(in: .whitespaces).isEmpty,
                  !dto.url.trimmingCharacters(in: .whitespaces).isEmpty,
                  let parsedDate = parseDate(from: dto.publishedAt) else {
                print("[ArticleDataStore] Skipped invalid article: \(dto.title)")
                continue
            }

            let request: NSFetchRequest<Article> = Article.fetchRequest()
            request.predicate = NSPredicate(format: "url == %@", dto.url)

            let existing = (try? context.fetch(request))?.first
            let article = existing ?? Article(context: context)

            article.title = dto.title
            article.url = dto.url
            article.author = dto.author ?? "Unknown Author"
            article.desc = dto.description ?? ""
            article.imageUrl = dto.urlToImage
            article.publishedAt = parsedDate

            if existing == nil {
                article.isBookmarked = false
            }
        }

        do {
            try context.save()
        } catch {
            print("[ArticleDataStore] Save failed: \(error.localizedDescription)")
        }
    }

    func fetchArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }

    func searchArticles(with query: String) -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
        request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }

    func toggleBookmark(for article: Article) -> Bool {
        article.isBookmarked.toggle()
        do {
            try context.save()
        } catch {
            print("[ArticleDataStore] Toggle failed: \(error.localizedDescription)")
        }
        return article.isBookmarked
    }

    func fetchBookmarkedArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "isBookmarked == YES")
        request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }
}
