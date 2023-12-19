//
//  NewsService.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 10.11.23.
//

import Foundation

struct NewsService {
    
    func fetchTopHeadlines() async throws -> [Article] {
        guard let url = URL(string: BASE_URL + TOP_HEADLINES + API_KEY) else {
            throw "The URL could not be created."
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        
        return decodedResponse.articles
    }
    
    func search(query: String) async throws -> [Article] {
        var language = ""
        
        switch LANGUAGE {
        case "EN":
            language = "en"
        default:
            language = "ru"
        }
        
        guard let url = URL(string: BASE_URL + "/everything?q=" + query + "&language=" + language + "&apiKey=" + API_KEY) else {
            throw "The URL could not be created."
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        
        return decodedResponse.articles
    }
}
