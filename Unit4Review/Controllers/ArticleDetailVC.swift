//
//  ArticleDetailVC.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArticleDetailVC: UIViewController {

    private var articleDetailView = ArticleDetailView()
    
    public var article: Article?
    
    override func loadView() {
        view = articleDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = .systemTeal
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
    

    private func updateUI() {
        guard let article = article else {
            fatalError("did not load an article")
        }
        navigationItem.title = article.title
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        
    }

}
