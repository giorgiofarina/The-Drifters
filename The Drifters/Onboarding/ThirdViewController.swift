//
//  ThirdViewController.swift
//  The Drifters
//
//  Created by Lucia Cotrozzi on 09/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "Onboarding")
        

        
    }
    
    
}
