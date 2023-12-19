//
//  CharacterService.swift
//  RickNMorty
//
//  Created by Murad Ismayilov on 07.12.23.
//

import Foundation

struct CharacterService {
    
    let BASE_URL = "https://rickandmortyapi.com/api"
    
    func fetchCharacters(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: BASE_URL + "/character/?page=\(page)") else {
            print("The URL could not be created.")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
    
    func filterCharactersByGender(page: Int, gender: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: BASE_URL + "/character/?page=\(page)&gender=" + gender) else {
            print("The URL could not be created.")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
    
    func filterCharactersByStatus(page: Int, status: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: BASE_URL + "/character/?page=\(page)&status=" + status) else {
            print("The URL could not be created.")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
    
    func filterCharactersByName(page: Int, name: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: BASE_URL + "/character/?page=\(page)&name=" + name) else {
            print("The URL could not be created.")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
}
