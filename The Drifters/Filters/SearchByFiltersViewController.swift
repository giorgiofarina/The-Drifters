//
//  SearchByFiltersViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 11/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit
import CoreLocation

class SearchByFiltersViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate, UISearchBarDelegate {
    
    
    
        
        @IBOutlet weak var scrollView: UIScrollView!
        
        @IBOutlet weak var currentLocationButton: UIButton!

        @IBOutlet weak var matchingButton: UIButton!
    
        @IBOutlet weak var dedicationButton: UIButton!
        @IBOutlet weak var categoryButton: UIButton!
        @IBOutlet weak var spaceButton: UIButton!
        @IBOutlet weak var brightnessButton: UIButton!
    
        @IBOutlet weak var categoryTextField: UITextField!{
            didSet {
                categoryTextField.delegate = self
            }
        }
        @IBOutlet weak var spaceTextField: UITextField!{
            didSet {
                spaceTextField.delegate = self
            }
        }
    
    
    
    
        @IBOutlet weak var dedicationTextField: UITextField!
        @IBOutlet weak var brightnessTextField: UITextField!
    
        @IBOutlet weak var searchBar: UISearchBar!
    
    

    
    
        let categoryPickerView = UIPickerView()
        let spacePickerView = UIPickerView()
        let dedicationPickerView = UIPickerView()
    
    
        let category = ["Officinal Plants",
                    "Ornamental Plants",
                    "Aquatic Plants",
                    "Vegetables", "Fruit Plants"]
        let space = ["Inside","Outside"]
    
        let dedication = ["5min per day",
                      "15min per day",
                      "1h per day",
                      "more than 1h per day", "1h per week"]
    
    
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
            self.navigationController?.isNavigationBarHidden = true
            
            scrollView.isScrollEnabled = false
            scrollView.contentInsetAdjustmentBehavior = .never
            
    //SETTING SHAPES OF THE BUTTON
            categoryButton.layer.cornerRadius = 10
            categoryButton.layer.masksToBounds = true
            spaceButton.layer.cornerRadius = 10
            spaceButton.layer.masksToBounds = true
            dedicationButton.layer.cornerRadius = 10
            dedicationButton.layer.masksToBounds = true
            matchingButton.layer.cornerRadius = 10
            matchingButton.layer.masksToBounds = true
            brightnessButton.layer.cornerRadius = 10
            brightnessButton.layer.masksToBounds = true
            currentLocationButton.layer.cornerRadius = currentLocationButton.frame.size.width / 2
            currentLocationButton.clipsToBounds = true
            
     
            
            
    //SET TOOLBAR
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.cancelClicked))
            
           
            toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
            
            categoryTextField.inputAccessoryView = toolbar
            spaceTextField.inputAccessoryView = toolbar
            dedicationTextField.inputAccessoryView = toolbar
            
            categoryPickerView.dataSource = self
            categoryPickerView.delegate = self
            
            spacePickerView.dataSource = self
            spacePickerView.delegate = self
            
            dedicationPickerView.dataSource = self
            dedicationPickerView.delegate = self
            
            categoryTextField.tintColor = UIColor.clear
            spaceTextField.tintColor = UIColor.clear
            dedicationTextField.tintColor = UIColor.clear
            
            categoryTextField.inputView = categoryPickerView
            spaceTextField.inputView = spacePickerView
            dedicationTextField.inputView = dedicationPickerView
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
            
            
        }
    
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    
        @objc func viewTapped(sender: UITapGestureRecognizer) {
            categoryTextField.resignFirstResponder()
            spaceTextField.resignFirstResponder()
            dedicationTextField.resignFirstResponder()
        }
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            if (textField == categoryTextField || textField == spaceTextField ){
            scrollView.setContentOffset(CGPoint(x: 0, y: 220), animated: true)
            }
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            if (textField == categoryTextField || textField == spaceTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
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
        
        
    //PICKER
    
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
 
        if pickerView == categoryPickerView {
            return category.count
        } else if pickerView == spacePickerView {
            return space.count
        } else {
            return dedication.count
        }
        
    }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == categoryPickerView {
                return category[row]
            } else if pickerView == spacePickerView{
                return space[row]
            } else {
                return dedication[row]
            }
           
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            
            if pickerView == categoryPickerView {
                categoryTextField.text = category[row]
            } else if pickerView == spacePickerView{
                spaceTextField.text = space[row]
            } else {
                dedicationTextField.text = dedication[row]
            }
          
            scrollView.isScrollEnabled = false
        }
    
    
        @objc func doneClicked() {
            categoryTextField.resignFirstResponder()
            spaceTextField.resignFirstResponder()
            dedicationTextField.resignFirstResponder()
            view.endEditing(true)
        }
    
        @objc func cancelClicked() {
            view.endEditing(true)
        }

 
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        }
    
//        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange SelectedScope: Int) -> Bool {
//            return true
//        }
    
        private func setUpSearchBar(){
            searchBar.delegate = self
        }
}


