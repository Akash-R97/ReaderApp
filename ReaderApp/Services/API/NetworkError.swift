//
//  NetworkError.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
}

