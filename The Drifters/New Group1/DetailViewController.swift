//
//  DetailViewController.swift
//  The Drifters
//
//  Created by Mariapia Pansini on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var destinationImage: UIImageView!
    @IBOutlet weak var destinationName: UILabel!
    @IBOutlet weak var buttonIcon: UIBarButtonItem!
    @IBOutlet weak var trashButtonIcon: UIBarButtonItem!
    
    var image = UIImage()
    var namePlant = UILabel()
    var plantObject = Plant()
    var list: [Plant] = []
    var list2: [Plant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        destinationImage.image = image
        destinationName.text = namePlant.text
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if DataModel.shared.originView{
            buttonIcon.isEnabled = false
            buttonIcon.tintColor = .clear
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func alertMessageForGarden (title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//            let wishList = ritornaLista(nomeLista: "Wishlist")
            let gardenList = ritornaLista(nomeLista: "Garden")

//            rimuoviPianta(istanzaPianta: self.plantObject, istanzaLista: wishList)
            aggiungiPianta(istanzaPianta: self.plantObject, istanzaLista: gardenList)
            print("pianta aggiunta al garden")
            self.list = mostraLista(istanzaLista: gardenList)
            print("\(self.list[0])")

        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in

            alert.dismiss(animated: true, completion: nil)
            print("pianta non aggiunta")
        }))

        self.present(alert, animated: true , completion: nil)

    }


    @IBAction func addToGardenList(_ sender: Any) {

        alertMessageForGarden(title:"Attention", message: "Are you sure you want to add this plant to your garden?" )
    }
    
    
    func alertMessageToRemovePlantFromList (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let gardenList = ritornaLista(nomeLista: "Garden")
            let wishList = ritornaLista(nomeLista: "Wishlist")
            
            if DataModel.shared.originView {

                rimuoviPianta(istanzaPianta: self.plantObject, istanzaLista: gardenList)
                print("pianta rimossa dal garden")
                self.list = mostraLista(istanzaLista: gardenList)
            } else {

                rimuoviPianta(istanzaPianta: self.plantObject, istanzaLista: wishList)
                print("pianta rimossa da wishList")
                self.list2 = mostraLista(istanzaLista: wishList)
            }
            appDelegate.saveContext()
            
    }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            alert.dismiss(animated: true, completion: nil)
            print("pianta non eliminata")
        }))
        
        self.present(alert, animated: true , completion: nil)
        
    }
    
    
    @IBAction func removeFromList(_ sender: Any) {
        alertMessageToRemovePlantFromList(title: "Attention", message: "Are you sure you want remove this plant from your list?")
    }
    
    
}
