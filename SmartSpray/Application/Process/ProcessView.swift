//
//  ProcessView.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

extension ProcessViewController {
    func setViews() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        view.addSubview(mainView)
        view.addSubview(imageView)
        view.addSubview(percentCoverageLabel)
        view.addSubview(saveButton)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            mainView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            mainView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            mainView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 32),
            imageView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 32),
            imageView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        percentCoverageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentCoverageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            percentCoverageLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            percentCoverageLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            percentCoverageLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: percentCoverageLabel.bottomAnchor, constant: 16),
            saveButton.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
