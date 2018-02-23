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
    var check: Bool = false

    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output = AVCaptureStillImageOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    
    var labelCameraNotEnable = UILabel()
    
    var notEnabledLabel: UILabel = {
        let notEnabledLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 270, height: 37))
        notEnabledLabel.center = CGPoint(x: 180, y: 300)
        notEnabledLabel.textColor = UIColor.gray
        notEnabledLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        notEnabledLabel.textAlignment = .center
        notEnabledLabel.text = ""
        return notEnabledLabel
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
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80 , height: 80)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transform
        activityIndicator.center = self.view.center
        self.activityIndicator.startAnimating()
        
        self.view.addSubview(notEnabledLabel)
       
        
        view.addSubview(activityIndicator)
        
        //        self.view.addSubview(button2)
        //        button2.addTarget(self, action:#selector(self.bottone2), for: .touchUpInside)
        
        //Initialize session an output variables this is necessary
        let camera = getDevice(position: .back)
        do {
            input = try AVCaptureDeviceInput(device: camera!)
            
        } catch let error as NSError {
            print(error)
            input = nil
        }
        
        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            
            check = false
            print("L'utente non ha consentito l'utilizzo della fotocamera")
            
            
            
            
        } else {
            self.session = AVCaptureSession()
            output = AVCaptureStillImageOutput()
            check = true
            if let session = session {
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
                }
                
                let dataOutput = AVCaptureVideoDataOutput()
                dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Eden"))
                session.addOutput(dataOutput)
            }
            
        }
            
    }
    
    
    var appoggio = Plant()
    
    
//    //        per coreml
//
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//
//        print("Entra nel capture!")
//        if check == true {
//          
//        print("L'utente ha consentito")
//            
//        let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//
//        let model = try? VNCoreMLModel(for: Oxford102().model)
//        let request = VNCoreMLRequest(model: model!){ (finishedReq, err) in
//
//            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
//            guard let firstObservation = results.first else {return}
//
//        DispatchQueue.main.async(execute: {
//            if firstObservation.confidence >= 0.8 {
//               
//                self.notEnabledLabel.text = " "
//                
//                
//                //controllo tra nome del modello al nome dal database
//
//                aggiungiFiltri(nomeFiltro: "commonName", valoreFiltro: firstObservation.identifier)
//                self.pianta = ricercaPerFiltri(arrayFiltri: filtri)
//
//                // self.session?.stopRunning()
//
//                if(self.pianta.count != 0){
//                    self.appoggio = self.pianta[0]
//
//                    self.showActionSheet(Message: "You've found" ,Title: "\(self.appoggio.commonName!)")
//                    self.tabBarController?.tabBar.isHidden = true
//                        self.activityIndicator.stopAnimating()
//                        self.notEnabledLabel.text = " "
//                    
//                    
//                }else {
//                    svuotaFiltri()
//                }
//            }
//        })
//
//
//            print(firstObservation.identifier, firstObservation.confidence)
//           sleep(1)
//        }
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//        }
//    }
//    
    func showActionSheet(Message: String, Title: String){
        
        let messageAlert = NSAttributedString(string: Message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light) , NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        let titleAlert = NSAttributedString(string: Title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.semibold) , NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        let actionSheet = UIAlertController(title: Message, message: Title, preferredStyle: .actionSheet)
       
        actionSheet.setValue(messageAlert, forKey: "attributedTitle")
        actionSheet.setValue(titleAlert, forKey: "attributedMessage")
        
        
        actionSheet.view.tintColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.tabBarController?.tabBar.isHidden = false
           
            self.activityIndicator.startAnimating()
           
            self.notEnabledLabel.text = ""
            self.session?.startRunning()
            svuotaFiltri()
        }
        
        let detail = UIAlertAction(title: "Show details", style: .default) { action in

            let garderStoryboard: UIStoryboard = UIStoryboard(name: "Camera", bundle: nil)
            let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "detailFromCameraID") as! DetailFromCameraViewController
            
            
            destinationView.plantObject = self.appoggio
            self.navigationController?.pushViewController(destinationView, animated: true)
            
            svuotaFiltri()
        }
        
        actionSheet.addAction(detail)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true, completion: nil)

    }
    
    
    
    func alertSettings(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.tintColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action: UIAlertAction!) in
        
            let url = URL(string:UIApplicationOpenSettingsURLString)
                
            _ =  UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
            
            
//            UIApplication.shared.open(URL(string: "App-Prefs:root=Eden")!, options: [:], completionHandler: nil)
            self.notEnabledLabel.text = ""
           
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            self.notEnabledLabel.text = "Camera not authorized"
          
        }))
        self.present(alert, animated: true , completion: nil)
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        self.session?.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.session?.startRunning()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.activityIndicator.startAnimating()
        
        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            
            check = false
            print("L'utente non ha consentito l'utilizzo della fotocamera")
            self.notEnabledLabel.text = "Camera not authorized"
            
            
            if DataModel.shared.isFirstTimeCamera{
                UserDefaults.standard.set(false, forKey: "Camera")
                self.notEnabledLabel.text = "Camera not authorized"
                
            }else  {
                
                alertSettings(title: "Camera Permissions", message: "You have turned off permission to camera for Eden. Please go to iOS settings and give permission.")
                self.notEnabledLabel.text = "Camera not authorized"
                
            }
        }
        

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
