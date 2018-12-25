//
//  HomeViewController+Delegates.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dogItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogcell", for: indexPath) as! DogItemCell
        DispatchQueue.global(qos: .userInitiated).async { () -> Void in
            if let url = URL(string: self.dogs[indexPath.row].url) , let imageData = try? Data(contentsOf: url), let img = UIImage(data:imageData){
                DispatchQueue.main.async {
                    dogItemCell.ImageView.image = img
                    dogItemCell.ActivityIndicator.stopAnimating()
                }
            }
        }
      
        return dogItemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    
}
