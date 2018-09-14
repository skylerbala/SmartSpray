//
//  SaveForm.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/9/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class SaveFormViewController: FormViewController {
    let saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(saveBarButtonTouch))
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Spray Card")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
            }
            <<< SwitchRow(){
                $0.title = "Add Geo-Location: Off"
                $0.value = false
                }.onChange({ (row) in
                    if row.value! {
                        row.title = "Add Geo-Location: On"
                    } else {
                        row.title = "Add Geo-Location: Off"
                    }
                })
            <<< TextAreaRow(){
                $0.title = "Description"
                $0.value = "Enter description here"
        }
        
        saveBarButton.target = self
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func saveBarButtonTouch() {
        // Save
        navigationController?.popViewController(animated: true)
    }
}
