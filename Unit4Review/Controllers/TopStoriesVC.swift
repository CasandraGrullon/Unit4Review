//
//  TopStoriesVC.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import DataPersistence

class TopStoriesVC: UIViewController {
    
    public var dataPersistence: DataPersistence<Article>!

    private var topStoriesView = TopStoriesView()
    
    private var newsArticles = [Article]() {
        didSet{
            DispatchQueue.main.async {
                self.topStoriesView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = topStoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        topStoriesView.collectionView.delegate = self
        topStoriesView.collectionView.dataSource = self
        topStoriesView.collectionView.register(TopStoriesCell.self, forCellWithReuseIdentifier: "topStoriesCell")
        getStories()
    }
    
    private func getStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let articles):
                self?.newsArticles = articles
            }
        }
    }
    
}

extension TopStoriesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topStoriesView.collectionView.dequeueReusableCell(withReuseIdentifier: "topStoriesCell", for: indexPath) as? TopStoriesCell else {
            fatalError("could not cast to topstoriescell")
        }
        cell.backgroundColor = .white
        let story = newsArticles[indexPath.row]
        cell.configureCell(for: story)
        return cell
    }
}
extension TopStoriesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = newsArticles[indexPath.row]
        
        let detailVC = ArticleDetailVC()
        detailVC.article = article
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
