//
//  ProcessView.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

extension AnalyzeViewController {
    func setViews() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        view.addSubview(mainView)
        view.addSubview(imageView)
        view.addSubview(percentCoverageLabel)
        view.addSubview(doneButton)
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
            imageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 16),
            imageView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: layoutGuide.layoutFrame.height / 1.75)
        ])
        
        percentCoverageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentCoverageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            percentCoverageLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            percentCoverageLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            percentCoverageLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: percentCoverageLabel.bottomAnchor, constant: 8),
            doneButton.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            doneButton.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            doneButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            ])
    
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 8),
            saveButton.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}
