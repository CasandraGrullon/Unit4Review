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
    
    private var sectionName = "Technology" {
        didSet {
            //getStories(for: sectionName)
            navigationItem.title = "\(sectionName) News"
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getStories()
    }
    
    private func getStories(for section: String = "Technology") {
        //retrieve sectionName from UserDefaults
        if let sectionName = UserDefaults.standard.object(forKey: UserKey.sectionName) as? String {
            if sectionName != self.sectionName {
                //we are looking at a new section
                //make a query
                queryAPI(for: sectionName)
                self.sectionName = sectionName
            }
        } else {
            //make default section selection ex: Technology
            queryAPI(for: sectionName)
        }
    }
    
    private func queryAPI(for section: String) {
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
        detailVC.dataPersistence = dataPersistence
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
