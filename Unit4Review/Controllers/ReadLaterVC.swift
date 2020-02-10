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

    private let readLaterView = ReadLaterView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    var savedArticles = [Article]() {
        didSet {
            print("there are \(savedArticles.count) articles saved")
            if savedArticles.isEmpty {
                //setup empty view on background of collection view
                readLaterView.collectionView.backgroundView = EmptyView.init(title: "Saved Articles", message: "There are currently no saved articles")
            } else {
                //remove empty view from collection view background
                readLaterView.collectionView.backgroundView = nil
            }
        }
    }
    override func loadView() {
        view = readLaterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
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
        let spacingBetweenItems: CGFloat = 10
        let numberofItems: CGFloat = 2
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberofItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxsize.width - totalSpacing) / numberofItems
        let itemHeight: CGFloat = maxsize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        //savedArticles.append(item)
        loadSavedArticles()
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item deleted")
    }
}
