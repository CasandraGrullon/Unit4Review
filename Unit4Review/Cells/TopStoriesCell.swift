//
//  TopStoriesCell.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import ImageKit

class TopStoriesCell: UICollectionViewCell {
    
    public var storyImage: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.image = UIImage(systemName: "photo")
        return imageV
    }()
    public var headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Headline"
        return label
    }()
    public var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        imageConstraints()
        headlineConstraints()
        abstractLabelConstraints()
    }
    
    private func imageConstraints() {
        addSubview(storyImage)
        storyImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            storyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            storyImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            storyImage.widthAnchor.constraint(equalTo: storyImage.heightAnchor)
        ])
    }
    private func headlineConstraints() {
        addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: storyImage.topAnchor, constant: 8),
            headlineLabel.leadingAnchor.constraint(equalTo: storyImage.trailingAnchor, constant: 8),
            headlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func abstractLabelConstraints() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 8),
            abstractLabel.trailingAnchor.constraint(equalTo: headlineLabel.trailingAnchor),
            abstractLabel.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor)
        ])
    }
    public func configureCell(for story: Article) {
        abstractLabel.text = story.abstract
        headlineLabel.text = story.title
        storyImage.getImage(with: story.multimedia.first?.url ?? "") { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.storyImage.image = UIImage(systemName: "eyeglasses")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.storyImage.image = image
                }
            }
        }
    }
}
