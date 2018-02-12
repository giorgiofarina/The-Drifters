//
//  MagnifyingGlassViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 10/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class MagnifyingGlassViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let elements = ["plant1", "plant2", "plant3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! SearchTableViewCell
        
        cell.customCellView.layer.cornerRadius = cell.customCellView.frame.height / 2
        
        
        cell.namePlantLabel.text = elements[indexPath.row]
        cell.plantImageView.image = UIImage(named: elements[indexPath.row])
        cell.plantImageView.layer.cornerRadius = cell.plantImageView.frame.height / 2
        
        return cell
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
