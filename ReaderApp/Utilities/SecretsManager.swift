//
//  SecretsManager.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
import Foundation

enum SecretsManager {
    static var newsAPIKey: String {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict["NewsAPIKey"] as? String
        else {
            fatalError("API Key not found in Secrets.plist.")
        }
        return key
    }
}

