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

    
    var plantArray: [Plant] = []
    var plantImage: [UIImage] = []
    var imageNoResult = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        suggestedTableView.delegate = self
        suggestedTableView.dataSource = self
        
        
        
        plantArray = ricercaPerFiltri(arrayFiltri: filtri)
    
        for each in plantArray{
            plantImage.append(generaImmagine(istanzaPianta: each))   
        }
       
        
        svuotaFiltri()
        
        self.suggestedTableView.separatorColor = UIColor.clear
        // Do any additional setup after loading the view.
        
        imageNoResult.frame = CGRect(x: 116, y: 307, width: 140, height: 26)
        imageNoResult.contentMode = .scaleAspectFit
        imageNoResult.image = #imageLiteral(resourceName: "imageNoResultFound")
        imageNoResult.isHidden = true
        self.view.addSubview(imageNoResult)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if plantArray.isEmpty {
            tableView.isHidden = true
            imageNoResult.isHidden = false
        } else{
            tableView.isHidden = false
            imageNoResult.isHidden = true
        }
        return plantArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customSuggestedCell") as! SuggestedTableViewCell
        
        cell.suggestedPlantNameLabel.text = plantArray[indexPath.row].commonName
        
        cell.suggestedPlantImageView.image = plantImage[indexPath.row]
    
        
        
        cell.suggestedPlantImageView.layer.cornerRadius = 10
        cell.suggestedPlantImageView.layer.masksToBounds = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let garderStoryboard: UIStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "detailsID") as! DetailsViewController
        
        destinationView.image = plantImage[indexPath.row]
        destinationView.commonName = plantArray[indexPath.row].commonName!
        destinationView.plantObject = plantArray[indexPath.row]
        
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
   
}
