//
//  ArticleDetailView.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    
    public var storyImage: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.image = UIImage(systemName: "photo")
        return imageV
    }()
    public var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract"
        return label
    }()
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "byLine"
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
        storyImageConstraints()
        abstractConstraints()
        byLineConstraints()
    }
    
    private func storyImageConstraints() {
        addSubview(storyImage)
        storyImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            storyImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func abstractConstraints() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: storyImage.bottomAnchor, constant: 8),
            abstractLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            abstractLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    private func byLineConstraints() {
        addSubview(byLine)
        byLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            byLine.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            byLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    
    
}
