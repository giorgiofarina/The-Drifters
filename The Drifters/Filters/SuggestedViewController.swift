//
//  SuggestedViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 14/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class SuggestedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var suggestedTableView: UITableView!
    
    let elements = ["001.jpg", "plant2", "plant3", "plant4", "plant5", "plant6", "plant7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        suggestedTableView.delegate = self
        suggestedTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = suggestedTableView.dequeueReusableCell(withIdentifier: "customSuggestedCell") as! SuggestedTableViewCell
        
        cell.suggestedView.layer.cornerRadius = cell.suggestedView.frame.height / 2
        
        cell.suggestedPlantNameLabel.text = elements[indexPath.row]
        cell.suggestedPlantImageView.image = UIImage(named: elements[indexPath.row])
        
        cell.suggestedPlantImageView.layer.cornerRadius = cell.suggestedPlantImageView.frame.height / 2
        
        return cell
    }
   
}
