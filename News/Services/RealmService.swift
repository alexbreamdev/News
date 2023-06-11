//
//  RealmService.swift
//  News
//
//  Created by Oleksii Leshchenko on 10.06.2023.
//

import RealmSwift
import SwiftUI
// MARK: - Realm Data Base
class RealmService: ObservableObject {
    private(set) var realm: Realm?
    @Published var articles: Results<ArticleRealm>?
    
    var articlesArray: [ArticleRealm] {
        if let articles = articles {
            return Array(articles)
        } else {
            return []
        }
    }
    
    var artArray: [ArticleViewModel] {
        return articlesArray.map(realmArticleToArticleObject)
    }
    
    private var articlesToken: NotificationToken?
    
    init(name: String) {
        initSchema(name: name)
        setupObserver()
    }
    
    func setupObserver() {
        guard let realm = realm else { return }
        let observedArticles = realm.objects(ArticleRealm.self)
        articlesToken = observedArticles.observe({[weak self] _ in
            self?.articles = observedArticles
        })
    }
    
    func initSchema(name: String) {
        if name == "previewRealm" {
            realm = self.previewRealm
        } else {
            // path for realm db on phone
            let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let realmFileUrl = docDir.appendingPathComponent("\(name).realm")
            let config = Realm.Configuration(fileURL: realmFileUrl, schemaVersion: 2, deleteRealmIfMigrationNeeded: true)
            
            Realm.Configuration.defaultConfiguration = config
            
            do {
                realm = try Realm()
            } catch {
                print("Couldn't setup Realm Data Base", error)
            }
        }
    }
    
    func objectExist(article: ArticleViewModel) -> Bool {
        guard let realm = realm else { return false }
        return realm.object(ofType: ArticleRealm.self, forPrimaryKey: article.id) != nil
    }
    
    func add(_ article: ArticleViewModel) {
        guard !objectExist(article: article) else { return }
        let realmArticle = ArticleRealm(article: article)
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(realmArticle)
                }
            } catch {
                print("Couldn't add to Articles")
            }
        }
    }
    
    func remove(_ article: ArticleViewModel) {
        if let realm = realm {
            if let articleToDelete = realm.object(ofType: ArticleRealm.self, forPrimaryKey: article.id) {
                do {
                    try realm.write {
                        realm.delete(articleToDelete)
                    }
                } catch {
                    print("Couldn't delete from Articles")
                }
            }
        }
    }
    
    func removeAll() {
        if let realm = realm {
            do {
                try realm.write {
                    realm.deleteAll()
                }
            } catch {
                print("Couldn't delete all articles")
            }
        }
    }
    
    private func realmArticleToArticleObject(realmArticle: ArticleRealm) -> ArticleViewModel {
        return ArticleViewModel(realmArticle)
    }
    
}

extension RealmService {
    var previewRealm: Realm {
        let identifier = "previewRealm"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            let articlesRealm = realm!.objects(ArticleRealm.self)
            if articlesRealm.count > 2 {
                return realm!
            } else {
                try realm!.write {
                    let article1 = ArticleRealm(article: ArticleViewModel())
                    let article2 = ArticleRealm(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
                    let article3 = ArticleRealm(article: ArticleViewModel(MockService.shared.articlesUSA[2])!)
                    realm!.add(article1)
                    realm!.add(article2)
                    realm!.add(article3)
                }
                return realm!
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}
