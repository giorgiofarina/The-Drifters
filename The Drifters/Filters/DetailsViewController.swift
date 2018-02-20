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
    @IBOutlet weak var characteristicsTitleLabel: UILabel!
    
    @IBOutlet weak var filtersInformationLabel: UILabel!
    
    @IBOutlet weak var addToFavouritesBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var addToGardenBarButtonItem: UIBarButtonItem!
    
    
    var commonName: String = ""
    var image = UIImage()
    var scientificName: String = ""
    var filtersLabel: String = ""
    
    
    var plantObject = Plant()
    var list: [Plant] = []
    var list2: [Plant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantImageView.image = image
        commonPlantNameLabel.text = commonName
        scientificPlantNameLabel.text = plantObject.scientificName
        descriptionPlantLabel.text = plantObject.generalDescription
        filtersInformationLabel.text = plantObject.climate
        
        
        
        
        
        
        
        plantImageView.layer.cornerRadius = 10
        plantImageView.layer.masksToBounds = true
        
    }

    
    
    func alertMessageForWishlist (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let wishList = ritornaLista(nomeLista: "Wishlist")
            
            aggiungiPianta(istanzaPianta: self.plantObject, istanzaLista: wishList)
            
            print("pianta aggiunta alla wishlist")
            self.list = mostraLista(istanzaLista: wishList)
            print("\(self.list[0])")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            alert.dismiss(animated: true, completion: nil)
            print("pianta non aggiunta")
        }))
        
        self.present(alert, animated: true , completion: nil)
        
    }

    

    @IBAction func addToFavouriteList(_ sender: Any) {

        alertMessageForWishlist(title:"Attention", message: "Are you sure you want to add this plant to your wishlist?" )
        
    }
    
    
    func alertMessageForGarden (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let gardenList = ritornaLista(nomeLista: "Garden")
            
            aggiungiPianta(istanzaPianta: self.plantObject, istanzaLista: gardenList)
            
            print("pianta aggiunta al garden")
            self.list2 = mostraLista(istanzaLista: gardenList)
            print("\(self.list2[0])")
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            alert.dismiss(animated: true, completion: nil)
            print("pianta non aggiunta")
        }))
        
        self.present(alert, animated: true , completion: nil)
        
    }


    @IBAction func addToGardenList(_ sender: Any) {
        
        alertMessageForGarden(title:"Attention", message: "Are you sure you want to add this plant to your garden?" )
    }
    
}
