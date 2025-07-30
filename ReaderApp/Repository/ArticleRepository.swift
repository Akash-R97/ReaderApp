//
//  ArticleRepository.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

final class ArticleRepository {

    private let apiService: APIServiceProtocol
    private let dataStore: ArticleDataStore

    init(apiService: APIServiceProtocol = APIService(),
         dataStore: ArticleDataStore = ArticleDataStore()) {
        self.apiService = apiService
        self.dataStore = dataStore
    }

    func fetchArticlesFromAPI(completion: @escaping (Result<[Article], Error>) -> Void) {
        apiService.fetchTopHeadlines { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.global(qos: .utility).async {
                switch result {
                case .success(let dtos):
                    self.dataStore.saveArticles(dtos)
                    let articles = self.dataStore.fetchArticles()
                    completion(.success(articles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchArticlesFromCache() -> [Article] {
        return dataStore.fetchArticles()
    }

    func searchArticles(with query: String) -> [Article] {
        return dataStore.searchArticles(with: query)
    }

    @discardableResult
    func toggleBookmark(for article: Article) -> Bool {
        return dataStore.toggleBookmark(for: article)
    }

    func fetchBookmarkedArticles() -> [Article] {
        return dataStore.fetchBookmarkedArticles()
    }
}
