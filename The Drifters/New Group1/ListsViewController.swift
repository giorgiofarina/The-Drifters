//
//  ListsViewController.swift
//  The Drifters
//
//  Created by Mariapia Pansini on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var pianteGiardino: [Plant] = []
    var pianteWishList: [Plant] = []
    var imageArrayTest1: [UIImage] = []     //array di immagini garden
    var imageArrayTest2: [UIImage] = []     //array immagini favorite
    var textArray1: [String] = []       //array di prova per le sezioni di garden
    var textArray2: [String] = []       //array di prova per le sezioni di favorite
    
    
    var imageSuggest = UIImageView()
    let buttonBar = UIView()
    
    
    class Responder: NSObject {
        @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        }
    }
    
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    var selectedSegment = 1
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControll.frame.width / CGFloat(self.segmentedControll.numberOfSegments)) * CGFloat(self.segmentedControll.selectedSegmentIndex)
        }
    }
    

    
    @IBAction func SelectSegmentedControll(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
            DataModel.shared.originView = true
        } else {
            selectedSegment = 2
            DataModel.shared.originView = false
        }
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let responder = Responder()
        
        segmentedControll.backgroundColor = .clear
        segmentedControll.tintColor = .clear
        segmentedControll.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedControll.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.black
            ], for: .selected)
        
        
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red: 175.0/255.0, green: 65.0/255.0, blue: 55.0/255.0, alpha: 1.00)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        // Constraint the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControll.leftAnchor).isActive = true
        // Constraint the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControll.widthAnchor, multiplier: 1 / CGFloat(segmentedControll.numberOfSegments)).isActive = true
        
        segmentedControll.addTarget(responder, action: #selector(responder.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        self.segmentedControll.reloadInputViews()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        imageSuggest.frame = CGRect(x: 27, y: 280, width: 321, height: 108)
        imageSuggest.contentMode = .scaleAspectFit
        imageSuggest.isHidden = true
        self.view.addSubview(imageSuggest)
        
        self.tableView.reloadData()
    }
    
    //  override function viewWillAppear to hidden FOREVER navigationBar in Lists view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        
        //        to delete background in the cell when the cell is selected
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        //        reload collection view data according to segmented control segment
        cell.clCollectionView.reloadData()
        cell.clCollectionView.tag = indexPath.section
        
        pianteGiardino = mostraLista(istanzaLista: ritornaLista(nomeLista: "Garden"))
        pianteWishList = mostraLista(istanzaLista: ritornaLista(nomeLista: "Wishlist"))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        return objects.count
        func tableView_HiddenWithNoPlantInList(itemInList: Int){
            if itemInList == 0 {
                tableView.isHidden = true
                imageSuggest.isHidden = false
            } else{
                tableView.isHidden = false
                imageSuggest.isHidden = true
            }
        }
        
        if selectedSegment == 1 {
            imageSuggest.image = #imageLiteral(resourceName: "imageGardenEmpty")
            pianteGiardino = mostraLista(istanzaLista: ritornaLista(nomeLista: "Garden"))
            textArray1 = classificaCategorie(arrayPiante: pianteGiardino)
            tableView_HiddenWithNoPlantInList(itemInList: pianteGiardino.count)

            return textArray1.count
        } else {
            imageSuggest.image = #imageLiteral(resourceName: "imageFavoriteEmpty")
            pianteWishList = mostraLista(istanzaLista: ritornaLista(nomeLista: "Wishlist"))
            textArray2 = classificaCategorie(arrayPiante: pianteWishList)
            tableView_HiddenWithNoPlantInList(itemInList: pianteWishList.count)

            return textArray2.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //   collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        var pianteUNAcategoria: [Plant] = []
        if selectedSegment == 1 {

            let categorie = classificaCategorie(arrayPiante: pianteGiardino)
            
                pianteUNAcategoria = piantePerCategoria(arrayPiante: pianteGiardino, categoria: categorie[collectionView.tag])
            

        } else {

            let categorie = classificaCategorie(arrayPiante: pianteWishList)
            pianteUNAcategoria = piantePerCategoria(arrayPiante: pianteWishList, categoria: categorie[collectionView.tag])
          
            

        }
        return pianteUNAcategoria.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsideCollectionViewCell", for: indexPath) as! InsideCollectionViewCell
        
        var pianteCategoria: [Plant] = []
        if selectedSegment == 1 {
            let categorie = classificaCategorie(arrayPiante: pianteGiardino)
            pianteCategoria = piantePerCategoria(arrayPiante: pianteGiardino, categoria: categorie[collectionView.tag])
            
        } else {
            let categorie = classificaCategorie(arrayPiante: pianteWishList)
            pianteCategoria = piantePerCategoria(arrayPiante: pianteWishList, categoria: categorie[collectionView.tag])
            
        }
        //        impostazioni per la struttura grafica delle immagini delle collectionView
        

        cell.imageCell.image = generaImmagine(istanzaPianta: pianteCategoria[indexPath.row])
        cell.imageCell.layer.cornerRadius = 10
        cell.imageCell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let garderStoryboard: UIStoryboard = UIStoryboard(name: "MyGarden", bundle: nil)
        let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        
         var pianteCategoria: [Plant] = []
        if selectedSegment == 1 {
            let categorie = classificaCategorie(arrayPiante: pianteGiardino)
            pianteCategoria = piantePerCategoria(arrayPiante: pianteGiardino, categoria: categorie[collectionView.tag])
            

            destinationView.plantObject = pianteCategoria[indexPath.row]
        } else {
            let categorie = classificaCategorie(arrayPiante: pianteWishList)
            pianteCategoria = piantePerCategoria(arrayPiante: pianteWishList, categoria: categorie[collectionView.tag])
            
    
            destinationView.plantObject = pianteCategoria[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    
    //    header tableView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        
        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "backgroundTitle")
        backgroundImage.frame = CGRect(x: 7, y: 6, width: 361, height: 25)
        sectionView.addSubview(backgroundImage)
        let titleSectionLabel = UILabel()
        if selectedSegment == 1 {
            titleSectionLabel.text = (textArray1[section]).firstUppercased
        } else {
            titleSectionLabel.text = (textArray2[section]).firstUppercased
        }
        sectionView.addSubview(titleSectionLabel)
        titleSectionLabel.frame = CGRect(x: 20, y: 1, width: 346, height: 35)
        titleSectionLabel.textColor = .white
        titleSectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedSegment == 1 {
            return textArray1[section]
        } else {
            return textArray2[section]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
}


