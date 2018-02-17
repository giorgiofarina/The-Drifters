//
//  SearchByFiltersViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 11/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit
import CoreLocation

class SearchByFiltersViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIScrollViewDelegate {

        
        @IBOutlet weak var scrollView: UIScrollView!

    
        @IBOutlet weak var climateButton: UIButton!
        @IBOutlet weak var dedicationButton: UIButton!
        @IBOutlet weak var plantSizeButton: UIButton!
        @IBOutlet weak var categoryButton: UIButton!
        @IBOutlet weak var spaceButton: UIButton!
        @IBOutlet weak var brightnessButton: UIButton!
    
    
    
    
        @IBOutlet weak var climateTextField: UITextField!{
            didSet {
                climateTextField.delegate = self
            }
        }
        @IBOutlet weak var brightnessTextField: UITextField!{
            didSet {
                brightnessTextField.delegate = self
            }
        }
        @IBOutlet weak var dedicationTextField: UITextField!{
            didSet {
                dedicationTextField.delegate = self
            }
        }
        @IBOutlet weak var plantSizeTextField: UITextField!{
                didSet {
                    plantSizeTextField.delegate = self
                }
            }
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
 

    
        let climatePickerView = UIPickerView()
        let brightnessPickerView = UIPickerView()
        let dedicationPickerView = UIPickerView()
        let plantSizePickerView = UIPickerView()
        let categoryPickerView = UIPickerView()
        let spacePickerView = UIPickerView()
    
    
    
    let climate = ["None", "Tropical","Equatorial","Subtropical","Temperate","Wet temperate","Oceanic","Mediterranean",
        "Continental","Subarctic","Trans-Siberian","Polar","Glacial" ,"Steppe", "Desert" ,"Monsoon" , "Sinic" ,
        "Climate of the savannah","Alpine","Boreal"]
        let brightness = ["None", "Filtered light", "Bright light", "Average light", "Shadow", "Dim light", "Full sun"]
        let dedication = ["None", "Rarely", "Often", "Assiduously"]
        let plantSize = ["None", "Big","Medium","Small"]
        let category = ["None", "Aquatic", "Shrubby" ,"Bulbous" , "Creeper", "Officinal", "Herbaceous", "Bushy", "Fruit Plant",  ]
        let space = ["None", "Inside","Outside"]
    
    let ScrollingNavigationController = UINavigationController()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            self.navigationController?.isNavigationBarHidden = false
            
          self.navigationController?.navigationBar.shadowImage = UIImage()
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
            scrollView.delegate = self
            scrollView.isScrollEnabled = true
           
            
            
    //SETTING SHAPES OF THE BUTTON

            
            climateButton.layer.cornerRadius = 10
            climateButton.layer.masksToBounds = true
            brightnessButton.layer.cornerRadius = 10
            brightnessButton.layer.masksToBounds = true
            dedicationButton.layer.cornerRadius = 10
            dedicationButton.layer.masksToBounds = true
            plantSizeButton.layer.cornerRadius = 10
            plantSizeButton.layer.masksToBounds = true
            categoryButton.layer.cornerRadius = 10
            categoryButton.layer.masksToBounds = true
            spaceButton.layer.cornerRadius = 10
            spaceButton.layer.masksToBounds = true
            
 
            
            
    //SET TOOLBAR
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
            doneButton.tintColor = UIColor.red
            
            
           
            toolbar.setItems([flexibleSpace, doneButton], animated: false)
            
            climateTextField.inputAccessoryView = toolbar
            climatePickerView.dataSource = self
            climatePickerView.delegate = self
            climateTextField.tintColor = UIColor.clear
            climateTextField.inputView = climatePickerView
            
            
            brightnessTextField.inputAccessoryView = toolbar
            brightnessPickerView.dataSource = self
            brightnessPickerView.delegate = self
            brightnessTextField.tintColor = UIColor.clear
            brightnessTextField.inputView = brightnessPickerView
            
            
            dedicationTextField.inputAccessoryView = toolbar
            dedicationPickerView.dataSource = self
            dedicationPickerView.delegate = self
            dedicationTextField.tintColor = UIColor.clear
            dedicationTextField.inputView = dedicationPickerView
            
            
            plantSizeTextField.inputAccessoryView = toolbar
            plantSizePickerView.dataSource = self
            plantSizePickerView.delegate = self
            plantSizeTextField.tintColor = UIColor.clear
            plantSizeTextField.inputView = plantSizePickerView
            
   
            categoryTextField.inputAccessoryView = toolbar
            categoryPickerView.dataSource = self
            categoryPickerView.delegate = self
            categoryTextField.tintColor = UIColor.clear
            categoryTextField.inputView = categoryPickerView
            
            spaceTextField.inputAccessoryView = toolbar
            spacePickerView.dataSource = self
            spacePickerView.delegate = self
            spaceTextField.tintColor = UIColor.clear
            spaceTextField.inputView = spacePickerView
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
   
            
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
  
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        climateTextField.resignFirstResponder()
        brightnessTextField.resignFirstResponder()
        dedicationTextField.resignFirstResponder()
        plantSizeTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        spaceTextField.resignFirstResponder()
        return true
    }
    
            
    
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if (textField == dedicationTextField || textField == plantSizeTextField ){
            scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: true)
            } else if (textField == categoryTextField || textField == spaceTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 320), animated: true)
            }
        }
    
        func textFieldDidEndEditing(_ textField: UITextField) {
            if (textField == dedicationTextField || textField == plantSizeTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else if (textField == categoryTextField || textField == spaceTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            }
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

    
        
    //PICKER
    
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
            if pickerView == climatePickerView {
                return climate.count
            } else if pickerView == brightnessPickerView {
                return brightness.count
            } else if pickerView == dedicationPickerView {
                return dedication.count
            } else if pickerView == plantSizePickerView {
                return plantSize.count
            } else if pickerView == categoryPickerView {
                return category.count
            } else {
                return space.count
            }
            
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == climatePickerView {
                return climate[row]
            } else if pickerView == brightnessPickerView {
                return brightness[row]
            } else if pickerView == dedicationPickerView {
                return dedication[row]
            } else if pickerView == plantSizePickerView {
                return plantSize[row]
            } else if pickerView == categoryPickerView {
                return category[row]
            } else {
                return space[row]
            }
           
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            if pickerView == climatePickerView {
                climateTextField.text = climate[row]
            } else if pickerView == brightnessPickerView {
                brightnessTextField.text = brightness[row]
            } else if pickerView == dedicationPickerView {
                dedicationTextField.text = dedication[row]
            } else if pickerView == plantSizePickerView {
                plantSizeTextField.text = plantSize[row]
            } else if pickerView == categoryPickerView {
                categoryTextField.text = category[row]
            } else {
                return spaceTextField.text = space[row]
            }
           

        }
    
    
        @objc func doneClicked() {
            climateTextField.resignFirstResponder()
            brightnessTextField.resignFirstResponder()
            dedicationTextField.resignFirstResponder()
            plantSizeTextField.resignFirstResponder()
            categoryTextField.resignFirstResponder()
            spaceTextField.resignFirstResponder()
            
            view.endEditing(true)
        }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        view.endEditing(true)
    }

}


