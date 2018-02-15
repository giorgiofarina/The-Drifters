//
//  TabBarMainViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 12/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class TabBarMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let unselectedColor   = UIColor(red: 1.42, green: 1.42, blue: 1.47, alpha: 1.0)
        let selectedColor = UIColor(red: 1.55, green: 0.19, blue: 0.00, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
