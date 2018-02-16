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

   
    
    
    var elements = ["001.jpg", "plant2", "plant3"]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
       
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    
        self.tableView.separatorColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }


    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! SearchTableViewCell
 
        cell.customCellView.layer.cornerRadius = 10
        cell.namePlantLabel.text = elements[indexPath.row]
        cell.plantImageView.image = UIImage(named: elements[indexPath.row])
        cell.plantImageView.layer.cornerRadius = 10
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }

    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

//     if let destination = segue.destinison as? DetailsViewController{
//        destination.elements = elements[(tableView.indexPathForSelectedRow?.row)!]
//        }
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
