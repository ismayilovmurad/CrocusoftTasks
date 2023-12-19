//
//  Global.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 10.11.23.
//
import CoreData

let BASE_URL = "https://newsapi.org/v2"
let API_KEY = "ebbf74e30b7045d09349e187fd255ef7"
let TOP_HEADLINES = "/top-headlines?country=us&apiKey="
var LANGUAGE = "EN"
var articles = [Article]()
var savedNews = [NSManagedObject]()

func getManagedContext() {
    
}
