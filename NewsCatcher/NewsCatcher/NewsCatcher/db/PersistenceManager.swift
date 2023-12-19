//
//  PersistenceManager.swift
//  NewsCatcher
//
//  Created by Murad Ismayilov on 18.11.23.
//

import CoreData

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsCatcher")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func save(article: Article) {
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)!
        
        let news = NSManagedObject(entity: entity, insertInto: context)
        
        news.setValue(article.author, forKey: "author")
        news.setValue(article.content, forKey: "content")
        news.setValue(article.description, forKey: "description_")
        news.setValue(article.publishedAt, forKey: "publishedAt")
        news.setValue(article.title, forKey: "title")
        news.setValue(article.url, forKey: "url")
        news.setValue(article.urlToImage, forKey: "urlToImage")
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
       do {
           let fetchResult = try self.context.fetch(request)
           return fetchResult
       } catch {
           print(error.localizedDescription)
           return []
       }
    }

    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
       self.context.delete(object)
       do {
           try self.context.save()
           return true
       } catch {
           return false
       }
    }
 }
