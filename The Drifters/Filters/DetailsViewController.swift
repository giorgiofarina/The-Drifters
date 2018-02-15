//
//  DetailsViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 14/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    let elements = ["001.jpg", "plant2", "plant3", "plant4", "plant5", "plant6", "plant7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        descriptionLabel.text = elements[IndexPath.row]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
