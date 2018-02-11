//
//  MagnifyingGlassViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 10/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class MagnifyingGlassViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    

//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange SelectedScope: Int) -> Bool {
//        
//    }
    
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
}
