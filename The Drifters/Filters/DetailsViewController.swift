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
    
    @IBOutlet weak var addToFavouritesBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var addToGardenBarButtonItem: UIBarButtonItem!
    
    
    var commonName: String = ""
    var image = UIImage()
    
    var plantObject = Plant()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantImageView.image = image
        commonPlantNameLabel.text = commonName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertMessage (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true , completion: nil)
        
    }
    

    @IBAction func addToFavouriteList(_ sender: Any) {
        

       aggiungiPianta(istanzaPianta: plantObject, istanzaLista: DataModel.shared.wishList)
        
    }
    

    @IBAction func addToGardenList(_ sender: Any) {
       aggiungiPianta(istanzaPianta: plantObject, istanzaLista: DataModel.shared.gardenList)
    
    }
    
}
