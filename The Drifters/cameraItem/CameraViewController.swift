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
    var pianta : [Plant] = []
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output = AVCaptureStillImageOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    let label2: UILabel = {
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 270, height: 37))
        label2.center = CGPoint(x: 150, y: 50)
        label2.textColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        label2.lineBreakMode = .byWordWrapping
//        label2.numberOfLines = 2

        label2.font = UIFont.boldSystemFont(ofSize: 20.0)
        label2.textAlignment = .center
        label2.text = " "
        label2.layer.cornerRadius = 10.0
        label2.clipsToBounds = true
        return label2
    }()
    
    let button2: UIButton = {
        let image = UIImage(named: "iconPlus") as UIImage?
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 37))
        button2.center = CGPoint(x: 350, y: 50)
        button2.tintColor = UIColor.white
        button2.contentVerticalAlignment = .center
        button2.setImage(image, for: [])
        button2.backgroundColor = .white
        button2.layer.cornerRadius = 10.0
        button2.clipsToBounds = true
        return button2
    }()

    var list : [Plant] = []
    
    @IBOutlet weak var CameraV: UIView!
    
    @objc func bottone2 (){
        let wishList = ritornaLista(nomeLista: "Wishlist")
        aggiungiPianta(istanzaPianta: pianta[0], istanzaLista: wishList)
        print("pianta aggiunta ai preferiti")
        self.list = mostraLista(istanzaLista: wishList)
        print("\(self.list[0])")
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
      
        
        self.view.addSubview(label2)
        self.view.addSubview(button2)
        
        button2.addTarget(self, action:#selector(self.bottone2), for: .touchUpInside)
        
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
//
//                self.label2.text = "\(firstObservation.identifier) \(firstObservation.confidence)"
//                self.label2.backgroundColor = .white
//
////                controllo tra nome del modello al nome dal database
//               aggiungiFiltri(nomeFiltro: "commonName", valoreFiltro: firstObservation.identifier)
//                self.pianta = ricercaPerFiltri(arrayFiltri: filtri)
//               svuotaFiltri()
//                if(self.pianta.count != 0){
//                    self.label.text = "\(String(describing: self.pianta[0].generalDescription!))"
//
//                    self.label.backgroundColor = .white
//                }
//                else{
//                    self.label.text = " "
//                    self.label.backgroundColor = .clear
//                }
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
