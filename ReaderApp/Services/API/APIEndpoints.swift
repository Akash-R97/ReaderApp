//
//  APIEndpoints.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

enum APIEndpoints {
    static let baseURL = "https://newsapi.org/v2/"
    static var topHeadlines: String {
        return baseURL + "top-headlines?country=us&apiKey=\(SecretsManager.newsAPIKey)"
    }
}

