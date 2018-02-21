//
//  DetailsViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 14/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var commonPlantNameLabel: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var scientificPlantNameLabel: UILabel!
    @IBOutlet weak var descriptionPlantLabel: UILabel!
    @IBOutlet weak var filtersInformationLabel: UILabel!
    @IBOutlet weak var cultivationMethodsLabel: UILabel!
    @IBOutlet weak var propagationLabel: UILabel!
    @IBOutlet weak var illnessesLabel: UILabel! 
    
    @IBOutlet weak var addToFavouritesBarButtonItem: UIBarButtonItem!
    
    
    
    var plantObject = Plant()
    var list: [Plant] = []
    var list2: [Plant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantImageView.image = generaImmagine(istanzaPianta: plantObject)
        commonPlantNameLabel.text = plantObject.commonName
        scientificPlantNameLabel.text = plantObject.scientificName
        descriptionPlantLabel.text = plantObject.generalDescription
        filtersInformationLabel.text = ("Origins: \(String(describing: plantObject.origins!))\nCategory: \(String(describing: plantObject.category!))\nClimate: \(String(describing: plantObject.climate!))\nExposure: \(String(describing: plantObject.exposure!))\nDedication: \(String(describing: plantObject.dedication!))\nPlant size: \(String(describing: plantObject.size!))\nEnvironment: \(String(describing: plantObject.environment!))\nFlowering: \(String(describing: plantObject.flowering!))")
        cultivationMethodsLabel.text = ("Fertilization: \(String(describing: plantObject.fertilization!))\nPruning: \(String(describing: plantObject.pruning!))\nRepotting: \(String(describing: plantObject.repotting!))\nIrrigation: \(String(describing: plantObject.irrigation!))")
        propagationLabel.text = plantObject.propagation
        illnessesLabel.text = plantObject.illnesses
        
    
        
        
        plantImageView.layer.cornerRadius = 10
        plantImageView.layer.masksToBounds = true
        
        
        
    }

    
    
    func alertMessageForWishlist (title: String, message: String) {
  
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
      
        alert.view.tintColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        alert.addAction(UIAlertAction(title: "Add to Wishlist", style: .default, handler: { (action: UIAlertAction!) in

            let wishList = ritornaLista(nomeLista: "Wishlist")
            
            aggiungiPianta(istanzaPianta: self.plantObject, istanzaLista: wishList)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Add to Garden", style: .default, handler: { (action: UIAlertAction!) in
            
            let gardenList = ritornaLista(nomeLista: "Garden")
            
            aggiungiPianta(istanzaPianta: self.plantObject, istanzaLista: gardenList)

        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            alert.dismiss(animated: true, completion: nil)
         
        }))
        
        self.present(alert, animated: true , completion: nil)
        
    }

    

    @IBAction func addToFavouriteList(_ sender: Any) {

        alertMessageForWishlist(title:"Attention", message: "\nAre you sure you want to add this plant to your list?" )
        
    }

}
