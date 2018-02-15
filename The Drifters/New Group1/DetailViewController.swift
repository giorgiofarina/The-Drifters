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
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        destinationImage.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
