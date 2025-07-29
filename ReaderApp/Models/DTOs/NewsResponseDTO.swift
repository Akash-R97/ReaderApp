//
//  NewsResponseDTO.swift
//  ReaderApp
//
//  Created by Akash Razdan on 29/07/25.
//
import Foundation

struct NewsResponseDTO: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleDTO]
}

