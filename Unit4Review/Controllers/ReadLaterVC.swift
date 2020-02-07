//
//  ReadLaterVC.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import DataPersistence

class ReadLaterVC: UIViewController {

    public var dataPersistence: DataPersistence<Article>!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }

    private func loadSavedArticles() {
        do {
            articles = try dataPersistence.loadItems()
        } catch {
            print("could not load saved articles: \(error)")
        }
    }

}


extension ReadLaterVC: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        //articles.append(item)
        print("item saved")
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item deleted")
    }
}
