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

        let unselectedColor   = UIColor(red: 160.0/255.0, green: 156.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        let selectedColor = UIColor(red: 155.0/255.0, green: 19.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        
        if DataModel.shared.isFirstTime{
          selectedIndex = 2
        } else {
            selectedIndex = 0
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
