//
//  ViewController.swift
//  CustomCameraMedium
//
//  Created by Raman Singh on 2018-07-03.
//  Copyright © 2018 Raman Singh. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {
    
    
    @IBOutlet weak var previewView: PreviewView!
    
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let capturePhotoOutput = AVCapturePhotoOutput()
    let capturePhotoDelegate = CapturePhotoDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCameraUsagePermission()
    }
    
    
    func initialiseCaptureSession() {
        
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice!),
            captureSession.canAddInput(input)
            else { return }
        
        captureSession.addInput(input)
        self.previewView.videoPreviewLayer.session = self.captureSession
        self.previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        capturePhotoOutput.isHighResolutionCaptureEnabled = true
        captureSession.addOutput(capturePhotoOutput)
        
        captureSession.startRunning()
    }
    
    @IBAction func onTapTakePhoto(_ sender: UIButton) {
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: capturePhotoDelegate)
        
    }
    
    func checkCameraUsagePermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.initialiseCaptureSession()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.initialiseCaptureSession()
                }
            }
        case .denied:
            return
        case .restricted:
            return
        }
    }
    
}


    


