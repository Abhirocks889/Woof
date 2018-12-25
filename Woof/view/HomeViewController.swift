//
//  HomeViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import MaterialComponents

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retryButton: MDCButton!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var refreshButton: MDCFloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        
    }
    
    fileprivate func setViewsForApiCall() {
        collectionView.isHidden = true
        retryButton.isHidden = true
        messageText.text = "Fetching!!"
        refreshButton.setImage(UIImage(named: "ic_new_refresh"), for:.normal)
    }
    
    fileprivate func setUpUi(){
        setViewsForApiCall()
    }
    
    
    @IBAction func onRetryClicked(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
