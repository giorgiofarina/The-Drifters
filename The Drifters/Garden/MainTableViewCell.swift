//
//  MainTableViewCell.swift
//  The Drifters
//
//  Created by Mariapia Pansini on 15/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var clCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MainTableViewCell{

    func setCollectionViewDataSourceDelegate
        <D:UICollectionViewDelegate & UICollectionViewDataSource>
        ( _dataSourceDelegete: D, forRow row: Int)
    {
        clCollectionView.delegate = _dataSourceDelegete
        clCollectionView.dataSource = _dataSourceDelegete
        clCollectionView.reloadData()
    }
}


