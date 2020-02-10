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
    
    private var readLaterView = ReadLaterView()
    
    var savedArticles = [Article]() {
        didSet {
            print("there are \(savedArticles.count) articles saved")
        }
    }
    override func loadView() {
        view = readLaterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        loadSavedArticles()
        readLaterView.collectionView.delegate = self
        readLaterView.collectionView.dataSource = self
        readLaterView.collectionView.register(TopStoriesCell.self, forCellWithReuseIdentifier: "storyCell")
    }

    private func loadSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("could not load saved articles: \(error)")
        }
    }

}

extension ReadLaterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = readLaterView.collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as? TopStoriesCell else {
            fatalError("could not cast to cell")
        }
        let faved = savedArticles[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(for: faved)
        return cell
    }
}
extension ReadLaterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = savedArticles[indexPath.row]
        
        let detailVC = ArticleDetailVC()
        detailVC.article = article
        detailVC.dataPersistence = dataPersistence
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ReadLaterVC: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item saved")
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item deleted")
    }
}
