//
//  SearchByFiltersViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 11/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class SearchByFiltersViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIScrollViewDelegate {

        
        @IBOutlet weak var scrollView: UIScrollView!

    
        @IBOutlet weak var climateButton: UIButton!
        @IBOutlet weak var dedicationButton: UIButton!
        @IBOutlet weak var plantSizeButton: UIButton!
        @IBOutlet weak var categoryButton: UIButton!
        @IBOutlet weak var environmentButton: UIButton!
        @IBOutlet weak var exposureButton: UIButton!
    

    
        @IBOutlet weak var climateTextField: UITextField!{
            didSet {
                climateTextField.delegate = self
            }
        }
        @IBOutlet weak var exposureTextField: UITextField!{
            didSet {
                exposureTextField.delegate = self
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
        @IBOutlet weak var environmentTextField: UITextField!{
            didSet {
                environmentTextField.delegate = self
            }
        }
 

    
        let climatePickerView = UIPickerView()
        let exposurePickerView = UIPickerView()
        let dedicationPickerView = UIPickerView()
        let plantSizePickerView = UIPickerView()
        let categoryPickerView = UIPickerView()
        let environmentPickerView = UIPickerView()
    
    
    
        let climate = ["None", "Tropical","Equatorial","Subtropical","Temperate","Wet temperate","Oceanic","Mediterranean",
                       "Continental","Subarctic","Trans-Siberian","Polar","Glacial" ,"Steppe", "Desert" ,"Monsoon" , "Sinic" ,
                       "Climate of the savannah","Alpine","Boreal"]
        let exposure = ["None", "Filtered light", "Bright light", "Average light", "Shadow", "Dim light", "Full sun"]
        let dedication = ["None", "Rarely", "Often", "Assiduously"]
        let plantSize = ["None", "Big","Medium","Small"]
        let category = ["None", "Aquatic", "Shrubby" ,"Bulbous" , "Creeper", "Officinal", "Herbaceous", "Bushy", "Fruit Plant"]
        let environment = ["None", "Indoor","Outdoor"]
    
   
    
        
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
            exposureButton.layer.cornerRadius = 10
            exposureButton.layer.masksToBounds = true
            dedicationButton.layer.cornerRadius = 10
            dedicationButton.layer.masksToBounds = true
            plantSizeButton.layer.cornerRadius = 10
            plantSizeButton.layer.masksToBounds = true
            categoryButton.layer.cornerRadius = 10
            categoryButton.layer.masksToBounds = true
            environmentButton.layer.cornerRadius = 10
            environmentButton.layer.masksToBounds = true
            
 
            
            
    //ASSIGN PICKERVIEW TO EACH TEXTFIELD. SET ITS TOOLBAR.
            
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
            
            
            exposureTextField.inputAccessoryView = toolbar
            exposurePickerView.dataSource = self
            exposurePickerView.delegate = self
            exposureTextField.tintColor = UIColor.clear
            exposureTextField.inputView = exposurePickerView
            
            
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
            
            environmentTextField.inputAccessoryView = toolbar
            environmentPickerView.dataSource = self
            environmentPickerView.delegate = self
            environmentTextField.tintColor = UIColor.clear
            environmentTextField.inputView = environmentPickerView
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
   
            
        
        }
    

        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    
    
        @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            climateTextField.resignFirstResponder()
            exposureTextField.resignFirstResponder()
            dedicationTextField.resignFirstResponder()
            plantSizeTextField.resignFirstResponder()
            categoryTextField.resignFirstResponder()
            environmentTextField.resignFirstResponder()
            return true
        }
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if (textField == dedicationTextField || textField == plantSizeTextField ){
            scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: true)
            } else if (textField == categoryTextField || textField == environmentTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 320), animated: true)
            }
        }
    
        func textFieldDidEndEditing(_ textField: UITextField) {
            if (textField == dedicationTextField || textField == plantSizeTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            } else if (textField == categoryTextField || textField == environmentTextField ){
                scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            }
        }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            view.endEditing(true)
        }
    
        
    //PICKER
    
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
            if pickerView == climatePickerView {
                return climate.count
            } else if pickerView == exposurePickerView {
                return exposure.count
            } else if pickerView == dedicationPickerView {
                return dedication.count
            } else if pickerView == plantSizePickerView {
                return plantSize.count
            } else if pickerView == categoryPickerView {
                return category.count
            } else {
                return environment.count
            }
            
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == climatePickerView {
                return climate[row]
            } else if pickerView == exposurePickerView {
                return exposure[row]
            } else if pickerView == dedicationPickerView {
                return dedication[row]
            } else if pickerView == plantSizePickerView {
                return plantSize[row]
            } else if pickerView == categoryPickerView {
                return category[row]
            } else {
                return environment[row]
            }
           
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            if pickerView == climatePickerView {
                climateTextField.text = climate[row]
                aggiungiFiltri(nomeFiltro: "climate", valoreFiltro: climateTextField.text!)
            } else if pickerView == exposurePickerView {
                exposureTextField.text = exposure[row]
                aggiungiFiltri(nomeFiltro: "exposure", valoreFiltro: exposureTextField.text!)
            } else if pickerView == dedicationPickerView {
                dedicationTextField.text = dedication[row]
                aggiungiFiltri(nomeFiltro: "dedication", valoreFiltro: dedicationTextField.text!)
            } else if pickerView == plantSizePickerView {
                plantSizeTextField.text = plantSize[row]
                aggiungiFiltri(nomeFiltro: "#size", valoreFiltro: plantSizeTextField.text!)
            } else if pickerView == categoryPickerView {
                categoryTextField.text = category[row]
                aggiungiFiltri(nomeFiltro: "category", valoreFiltro: categoryTextField.text!)
            } else {
                environmentTextField.text = environment[row]
                aggiungiFiltri(nomeFiltro: "environment", valoreFiltro: environmentTextField.text!)
            }
        

        }
    
    
        @objc func doneClicked() {
            climateTextField.resignFirstResponder()
            exposureTextField.resignFirstResponder()
            dedicationTextField.resignFirstResponder()
            plantSizeTextField.resignFirstResponder()
            categoryTextField.resignFirstResponder()
            environmentTextField.resignFirstResponder()
            
            view.endEditing(true)
        }
    
    
    @IBAction func researchInDatabaseTapped(_ sender: Any) {
        
        let searchViewStoryboard: UIStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        let destinationView = searchViewStoryboard.instantiateViewController(withIdentifier: "searchInDatabaseID") as! MagnifyingGlassViewController
        
        
        
        
        self.navigationController?.pushViewController(destinationView, animated: true)
        
    }
    
    
    
    func alertMessage (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true , completion: nil)

    }
    

    
    @IBAction func matchingButtonTapped(_ sender: Any) {
        
        
        //Check if field is empty
        if (climateTextField.text == "Climate" && exposureTextField.text! == "Exposure" && dedicationTextField.text! == "Dedication" && plantSizeTextField.text! == "Plant size" && categoryTextField.text! == "Category" && environmentTextField.text! == "Environment")  {
            alertMessage(title:"Attention", message: "Please, enter at least one filter!" )
        } else {
        

            
            let searchViewStoryboard: UIStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
            let destinationView = searchViewStoryboard.instantiateViewController(withIdentifier: "suggestedViewID") as! SuggestedViewController
            
         
            
            
        self.navigationController?.pushViewController(destinationView, animated: true)
        }
        
    
    
    }
    
    

        
        
    
    
    

}
