//
//  ReadLaterView.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ReadLaterView: UIView {
   public lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.itemSize = CGSize(width: 100, height: 100)
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
      cv.backgroundColor = .systemGroupedBackground
      return cv
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
      setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
      addSubview(collectionView)
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
    }
}
