//
//  APIService.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

protocol APIServiceProtocol {
    func fetchTopHeadlines(completion: @escaping (Result<[ArticleDTO], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchTopHeadlines(completion: @escaping (Result<[ArticleDTO], Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.topHeadlines) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let responseDTO = try decoder.decode(NewsResponseDTO.self, from: data)
                completion(.success(responseDTO.articles))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

