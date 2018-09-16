//
//  ProcessActions.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/15/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit

extension AnalyzeViewController {
    @objc func doneButtonTouch(_ sender: UIButton) {
        navigationController?.popToViewController((navigationController?.viewControllers[0])!, animated: true)
    }
    
    @objc func saveButtonTouch(_ sender: UIButton) {
        let saveFormVC = SaveFormViewController()
        if !(navigationController?.topViewController is SaveFormViewController) {
            navigationController?.pushViewController(saveFormVC, animated: true)
        }
    }
}

