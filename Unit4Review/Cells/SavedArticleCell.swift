//
//  SavedArticleCell.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/10/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

protocol SavedArticleCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article)
}

class SavedArticleCell: UICollectionViewCell {
    
    // step 2: custom protocol
    weak var delegate: SavedArticleCellDelegate?
    
    // to keep track of the current cell's article
    private var currentArticle: Article!
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "The best headline I ever came across on NYT."
        label.numberOfLines = 0
        return label
    }()
    public lazy var articleImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.alpha = 0
        return iv
    }()
    private var isShowingImage = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupMoreButtonConstraints()
        setupArticleTitleConstraints()
        setupImageConstraints()
        addGestureRecognizer(longPressGesture)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        
        isShowingImage.toggle()
        guard let currentArticle = currentArticle else {
            return
        }
        articleImage.getImage(with: currentArticle.getArticleImageURL(for: .normal)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.articleImage.image = UIImage(systemName: "photo")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.articleImage.image = image
                    self?.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration = 1.0
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.articleImage.alpha = 1.0
                self.articleTitle.alpha = 0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.articleImage.alpha = 0
                self.articleTitle.alpha = 1
            }, completion: nil)
        }
        
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        // step 3: custom protocol
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setupArticleTitleConstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImageConstraints() {
        addSubview(articleImage)
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            articleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    public func configreCell(for savedArticle: Article) {
        currentArticle = savedArticle // associating the cell with its article
        articleTitle.text = savedArticle.title
    }
}
