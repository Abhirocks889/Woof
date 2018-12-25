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
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    var dogs:[Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFlowLayout(view.frame.size)
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshButton.setImage(UIImage(named: "ic_refresh"), for:.normal)
        setUpUi()
        fetchList()
    }
    
    fileprivate func fetchList(){
        HomeController.Shared.getMedicines(pageNum: "0"){
            (isSuccess,response,error) in
            if(isSuccess){
                self.dogs = response!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setViewAfterAPICall()
                }
            }else{
                DispatchQueue.main.async {
                   self.messageText.text = "Something went wrong!!"
                   self.retryButton.isHidden = false
                }
            }
        }
    }
    fileprivate func setViewsForApiCall() {
        collectionView.isHidden = true
        retryButton.isHidden = true
        refreshButton.isHidden = true
        messageText.text = "Fetching!!"
    }
    
    fileprivate func setViewAfterAPICall(){
        collectionView.isHidden = false
        refreshButton.isHidden = false
        imageView.isHidden = true
        messageText.isHidden = true
    }
    fileprivate func setUpUi(){
        setViewsForApiCall()
    }
    
    private func configureFlowLayout(_ withSize: CGSize) {
        let isLandscape = withSize.width > withSize.height
        let space: CGFloat = isLandscape ? 5 : 3
        let items: CGFloat = isLandscape ? 2 : 3
        let dimension = (withSize.width - ((items + 1) * space)) / items
        collectionFlowLayout?.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        collectionFlowLayout?.minimumInteritemSpacing = space
        collectionFlowLayout?.minimumLineSpacing = space
        collectionFlowLayout?.itemSize = CGSize(width: dimension, height: dimension)
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
