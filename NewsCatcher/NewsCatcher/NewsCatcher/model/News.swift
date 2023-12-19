//
//  News.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 10.11.23.
//

import Foundation

struct Response: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
