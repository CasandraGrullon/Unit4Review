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
        return imageV
    }()
    public var headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    public var captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        imageConstraints()
        headlineConstraints()
        captionConstraints()
    }
    
    private func imageConstraints() {
        addSubview(storyImage)
        storyImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            storyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            storyImage.heightAnchor.constraint(equalToConstant: 100),
            storyImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func headlineConstraints() {
        addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            headlineLabel.leadingAnchor.constraint(equalTo: storyImage.trailingAnchor, constant: 8),
            headlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func captionConstraints() {
        addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.bottomAnchor, multiplier: 10),
            captionLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: -8),
            captionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: storyImage.trailingAnchor, multiplier: 8)
        ])
    }
    public func configureCell(for story: Article) {
        captionLabel.text = story.multimedia.first?.caption
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
