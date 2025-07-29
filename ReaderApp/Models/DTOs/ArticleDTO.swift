//
//  ArticleDTO.swift
//  ReaderApp
//
//  Created by Akash Razdan on 29/07/25.
//
import Foundation

struct ArticleDTO: Codable {
    let title: String
    let author: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

