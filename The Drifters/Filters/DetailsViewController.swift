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
    
    let elements = ["001.jpg", "plant2", "plant3", "plant4", "plant5", "plant6", "plant7"]
    
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//fetch dati da database della pianta selezionata e popolamento campi descrittivi di ciascuna pianta
    
    

    @IBAction func addToFavouriteList(_ sender: Any) {

    }
    

    @IBAction func addToGardenList(_ sender: Any) {
        
    }
    
}
