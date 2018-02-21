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
        
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        //        self.view.addSubview(button2)
        //        button2.addTarget(self, action:#selector(self.bottone2), for: .touchUpInside)
        
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
//
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//
//
//        let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//
//        let model = try? VNCoreMLModel(for: Oxford102().model)
//        let request = VNCoreMLRequest(model: model!){ (finishedReq, err) in
//
//            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
//            guard let firstObservation = results.first else {return}
//
//            DispatchQueue.main.async(execute: {
//
//                self.label2.text = firstObservation.identifier
//
//
//                //controllo tra nome del modello al nome dal database
//
//                aggiungiFiltri(nomeFiltro: "commonName", valoreFiltro: firstObservation.identifier)
//                self.pianta = ricercaPerFiltri(arrayFiltri: filtri)
//                svuotaFiltri()
//
//                if(self.pianta.count != 0){
//                    //                    self.Alert(Title: "\(self.label2.text!)")
//                    self.showActionSheet(Title: "\(self.label2.text!)")
//                    self.tabBarController?.tabBar.isHidden = true
//
//                }
//                else{
//
//                }
//            })
//
//
//            print(firstObservation.identifier, firstObservation.confidence)
//            sleep(2)
//        }
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//    }
    
    func showActionSheet(Title: String){
        
        let titleAlert = NSAttributedString(string: Title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold) , NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        let actionSheet = UIAlertController(title: Title, message: nil, preferredStyle: .actionSheet)
        actionSheet.setValue(titleAlert, forKey: "attributedTitle")
        
        actionSheet.view.tintColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.tabBar.layer.zPosition = 0
        }
        
        let add = UIAlertAction(title: "Add to Wishilist", style: .default) { action in
            
            let wishList = ritornaLista(nomeLista: "Wishlist")
            aggiungiPianta(istanzaPianta: self.pianta[0], istanzaLista: wishList)
            self.tabBarController?.tabBar.isHidden = false
            
            
        }
        actionSheet.addAction(add)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    func Alert(Title: String) {
        
        //        let TitleString = NSAttributedString(string: Title, attributes: [NSAttributedStringKey.font : UIFont(name: "Helvetica-Bold", size: 15.0)!, NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let TitleString = NSAttributedString(string: Title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.heavy) , NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let alertController = UIAlertController(title: Title, message: nil, preferredStyle: .alert)
        
        alertController.setValue(TitleString, forKey: "attributedTitle")
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
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
