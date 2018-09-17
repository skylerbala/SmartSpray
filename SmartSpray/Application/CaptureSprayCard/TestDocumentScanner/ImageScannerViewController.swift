//
//  ImageScannerViewController.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/16/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//
//
//import UIKit
//import WeScan
//
//class ImageScannerViewController: UIViewController {
//
//    let scannerVC = ImageScannerController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        scannerVC.imageScannerDelegate = self
//        self.present(scannerVC, animated: true, completion: nil)
//        
//    }
//    
//
//}
//
//extension ImageScannerViewController: ImageScannerControllerDelegate {
//    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
//        scanner.dismiss(animated: true, completion: nil)
//    }
//    
//    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
//        scanner.dismiss(animated: true, completion: nil)
//    }
//    
//    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
//        print(error)
//    }
//    
//}

