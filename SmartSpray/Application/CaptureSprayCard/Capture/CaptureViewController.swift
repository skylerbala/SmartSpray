//
//  ViewController.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/3/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import AVFoundation
import IGRPhotoTweaks
import EZLoadingActivity

class CaptureViewController: UIViewController {
    
    let scannerVC = ImageScannerController()

    let captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var fronCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    let captureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 75 / 2
        button.addTarget(self, action: #selector(captureButtonTouch), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let screenEdgePanGestureRecognizer = {
       let gesture = UIScreenEdgePanGestureRecognizer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        navigationController?.setSmartSprayNavigationBar()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        scannerVC.imageScannerDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.displayTabBar(isHidden: false)
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                fronCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings.init(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: { (preparationComplete, error) in
                
            })
            captureSession.addOutput(photoOutput!)
            
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    @objc func captureButtonTouch() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

extension CaptureViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let image = UIImage(data: imageData)
            let cropVC = CropViewController()
            cropVC.delegate = self
            cropVC.image = image
            if !(navigationController?.topViewController is CropViewController) {
                navigationController?.pushViewController(cropVC, animated: true)
            }
        }
    }
}

extension CaptureViewController: IGRPhotoTweakViewControllerDelegate {
    func photoTweaksController(_ controller: IGRPhotoTweakViewController, didFinishWithCroppedImage croppedImage: UIImage) {
        let image = croppedImage
        let analyzeVC = AnalyzeViewController()
        analyzeVC.imageView.image = image
        if !(navigationController?.topViewController is AnalyzeViewController) {
            navigationController?.pushViewController(analyzeVC, animated: true)
        }
    }
    
    func photoTweaksControllerDidCancel(_ controller: IGRPhotoTweakViewController) {
        controller.navigationController?.popViewController(animated: false)
    }

}

extension CaptureViewController: ImageScannerControllerDelegate {
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        let croppedImage = results.scannedImage
        let analyzeVC = AnalyzeViewController()
        analyzeVC.imageView.image = croppedImage
        if !(navigationController?.topViewController is AnalyzeViewController) {
            navigationController?.pushViewController(analyzeVC, animated: true)
            scanner.dismiss(animated: true, completion: nil)
        }
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
    }
    
}

