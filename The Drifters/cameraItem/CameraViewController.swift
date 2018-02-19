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
    
    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        label.center = CGPoint(x: 170, y: 570)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.text = "I am a test label"
        return label
    }()
    
//    let button: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
//        button.center = CGPoint(x: 30, y: 45)
//        button.tintColor = UIColor.white
//        //        button.font = UIFont.boldSystemFont(ofSize: 20.0)
//        button.contentVerticalAlignment = .center
//        button.setTitle("X", for: .normal)
//        return button
//    }()
//
    
    @IBOutlet weak var CameraV: UIView!
    
   
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
      
        
        self.view.addSubview(label)
        
        
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
    
    
//    //        per coreml
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//
//
//
//
//
//        let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//
//        let model = try? VNCoreMLModel(for: Oxford102().model)
//        let request = VNCoreMLRequest(model: model!){ (finishedReq, err) in
//
//            //            print(finishedReq.results)
//            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
//            guard let firstObservation = results.first else {return}
//
//            DispatchQueue.main.async(execute: {
//                self.label.text = "\(firstObservation.identifier) \(firstObservation.confidence)"
//            })
//
//            
//            print(firstObservation.identifier, firstObservation.confidence)
//            sleep(3)
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
