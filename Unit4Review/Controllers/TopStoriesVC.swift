//
//  TopStoriesVC.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class TopStoriesVC: UIViewController {


    private var topStoriesView = TopStoriesView()
    var stories = [Article]() {
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
    }
    
    private func getStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let articles):
                self?.stories = articles
            }
        }
    }
    
}

extension TopStoriesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topStoriesView.collectionView.dequeueReusableCell(withReuseIdentifier: "topStoriesCell", for: indexPath) as? TopStoriesCell else {
            fatalError("could not cast to TopStoriesCell")
        }
        cell.backgroundColor = .white
        let article = stories[indexPath.row]
        cell.configureCell(for: article)
        return cell
    }
}
extension TopStoriesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
