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

    var plantArray: [Plant] = []
  
    
    var elements = ["001.jpg", "plant2", "plant3"]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
       
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = UIColor.clear
        
        searchBar.delegate = self
        setUpSearchBar()
        
//        self.fetchData()
        
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
 
  
        
//fetch per riempire le celle con info dal database in base alle keyword inserite nella barra di ricerca
        cell.namePlantLabel.text = elements[indexPath.row]
        cell.plantImageView.image = UIImage(named: elements[indexPath.row])
        
        
        
        
        
        
        cell.plantImageView.layer.cornerRadius = 10
        cell.plantImageView.layer.masksToBounds = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }

    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let garderStoryboard: UIStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "detailsID") as! DetailsViewController
        
        destinationView.image = UIImage(named: elements[indexPath.row])!
        
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return
        }
            print(searchText)
        
    }
    

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    private func setUpSearchBar(){
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    
    
    
//    func fetchData () {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        do{
//            plantArray = try context.fetch(Plant.fetchRequest())
//            for item in plantArray {
//
//               namePlantLabel.text = item.commonName
//
//            }
//        } catch {
//            print(error)
//        }
//    }
    
 
}
