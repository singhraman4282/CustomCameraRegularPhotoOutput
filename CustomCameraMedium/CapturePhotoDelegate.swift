//
//  CapturePhotoDelegate.swift
//  CustomCameraMedium
//
//  Created by Raman Singh on 2018-07-03.
//  Copyright © 2018 Raman Singh. All rights reserved.
//

import UIKit
import AVKit

class CapturePhotoDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    
    var photoData: Data?
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error = error {
            print("Error capturing photo: \(error)")
        } else {
            photoData = photo.fileDataRepresentation()
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        guard let photoData = photoData else {
            print("No photo data resource")
            return
        }
        let capturedImage = UIImage.init(data: photoData , scale: 1.0)
        if let image = capturedImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
    }
}
