//
//  SearchByFiltersViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 11/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit
import CoreLocation

class SearchByFiltersViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
        
        @IBOutlet weak var scrollView: UIScrollView!
        
        
        @IBOutlet weak var currentLocationButton: UIButton!
        
        
        @IBOutlet weak var categoryButton: UIButton!
        @IBOutlet weak var categoryLabel: UILabel!
        @IBOutlet weak var categoryPickerView: UIPickerView!
        
    
        
        var latitude: String = ""
        var longitude: String = ""
        
        var locationManager: CLLocationManager!
        var location : CLLocation! {
            didSet{
                latitude = "\(location.coordinate.latitude)"
                longitude = "\(location.coordinate.longitude)"
                
            }
            
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            scrollView.isScrollEnabled = false
            scrollView.contentInsetAdjustmentBehavior = .never
            
            
            categoryPickerView.isHidden = true
            categoryPickerView.delegate = self
            categoryPickerView.dataSource = self
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        //BUTTON TO GET THE CURRENT LOCATION
        
        @IBAction func currentLocationButtonTapped(_ sender: Any) {
            locationManager.startUpdatingLocation()
            print("location: \(location)")
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkCoreLocationPermission()
        }
        
        
        
        func checkCoreLocationPermission(){
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            } else if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .restricted {
                print("unauthorized location service")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
            location = (locations as! [CLLocation]).last
            locationManager.stopUpdatingLocation()
        }
        
        
        //PICKER TO SELECT THE TYPE OF PLANT
        @IBAction func categoryButtonPressed(_ sender: Any) {
            scrollView.isScrollEnabled = true
            scrollView.setContentOffset(CGPoint(x: 0, y: 120), animated: true)
            
            if categoryPickerView.isHidden {
                categoryPickerView.isHidden = false
            }
            
        }
        
        
        let category = ["Officinal Plants",
                        "Ornamental Plants",
                        "Aquatic Plants",
                        "Vegetables", "Fruit Plants"]
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        
        public func pickerView(_ pickerVSearchByFiltersViewControlleriew: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            return category.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return category[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            categoryLabel.text = category[row]
            categoryLabel.resignFirstResponder()
            categoryPickerView.isHidden = true
            scrollView.isScrollEnabled = false
        }
        
        
        //PICKER TO SELECT THE SPACE AVAILABLE
        
        
        @IBAction func spaceButtonPressed(_ sender: Any) {
            scrollView.isScrollEnabled = true
            scrollView.setContentOffset(CGPoint(x: 0, y: 120), animated: true)
            
        }
        
    
    

}
