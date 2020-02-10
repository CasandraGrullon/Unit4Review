//
//  ArticleDetailVC.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import DataPersistence

class ArticleDetailVC: UIViewController {

    private var articleDetailView = ArticleDetailView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    public var article: Article?
    
    override func loadView() {
        view = articleDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }

    private func updateUI() {
        guard let article = article else {
            fatalError("did not load an article")
        }
        navigationItem.title = article.title
        articleDetailView.abstractLabel.text = article.abstract
        articleDetailView.byLine.text = article.byline
        articleDetailView.storyImage.getImage(with: article.getArticleImageURL(for: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.articleDetailView.storyImage.image = UIImage(systemName: "photo")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.articleDetailView.storyImage.image = image
                }
            }
        }
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        sender.image = UIImage(systemName: "bookmark.fill")
        guard let story = article else {
            return
        }
        do {
            try dataPersistence.createItem(story)
        } catch {
            print("error creating item \(error)")
        }
    }

}
