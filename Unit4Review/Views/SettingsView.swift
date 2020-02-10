//
//  SettingsView.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    public lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
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
        pickerViewConstraints()
    }
    
    private func pickerViewConstraints() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}

