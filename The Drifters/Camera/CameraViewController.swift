//
//  CameraViewController.swift
//  The Drifters
//
//  Created by Lorenzo Caso on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit
import AVKit
import Vision
import CoreML

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    var madeL = UILabel()

    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output = AVCaptureStillImageOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    


    @IBOutlet weak var CameraV: UIView!
    
    

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        //Initialize session an output variables this is necessary
        let session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        let camera = getDevice(position: .back)
        do {
                input = try AVCaptureDeviceInput(device: camera!)
            
        } catch let error as NSError {
            print(error)
            input = nil
        }
        if(session.canAddInput(input!) == true){
            session.addInput(input!)
            output.outputSettings = [AVVideoCodecKey : AVVideoCodecType.jpeg]
            if(session.canAddOutput(output) == true){
                session.addOutput(output)
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewLayer?.frame = CameraV.bounds
                CameraV.layer.addSublayer(previewLayer!)
                session.startRunning()
                
                
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Eden"))
            session.addOutput(dataOutput)
        }
        
    }

    
    //    per coreml
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        
//        
//        
//        let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//        
//     let model = try? VNCoreMLModel(for: Oxford102().model)
//        let request = VNCoreMLRequest(model: model!){ (finishedReq, err) in
//        
//            //            print(finishedReq.results)
//            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
//            guard let firstObservation = results.first else {return}
//            
//            
//            print(firstObservation.identifier, firstObservation.confidence)
//        }
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//    }
//    
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
                return deviceConverted
            }
        }
        return nil
    }
    

    
}
