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

    private let articleDetailView = ArticleDetailView()
    
    private var dataPersistence: DataPersistence<Article>
    
    private var article: Article
    
    private lazy var tapGesture: UITapGestureRecognizer = {
       let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    init(_ dataPersistence: DataPersistence<Article>, article: Article) {
        self.dataPersistence = dataPersistence
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func loadView() {
        view = articleDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
        articleDetailView.storyImage.isUserInteractionEnabled = true
        articleDetailView.storyImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        let image = articleDetailView.storyImage.image ?? UIImage()
        //need an instance of ZoomImageViewController from storyboard
        let zoomImageStoryBoard = UIStoryboard(name: "ZoomImage", bundle: nil)
        let zoomImageViewController = zoomImageStoryBoard.instantiateViewController(identifier: "ZoomImageViewController") { coder in
            return ZoomImageViewController(coder: coder, image: image)
        }
        present(zoomImageViewController, animated: true)
        
    }

    private func updateUI() {
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
        
        do {
            try dataPersistence.createItem(article)
        } catch {
            print("error creating item \(error)")
        }
    }

}
