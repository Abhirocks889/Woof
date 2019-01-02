//
//  HomeViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import MaterialComponents
import CoreData

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retryButton: MDCButton!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var refreshButton: MDCFloatingButton!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    var dogs:[CoreDataDog] = []
    var page = 0
    var fetchedResultsController:NSFetchedResultsController<CoreDataDog>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFlowLayout(view.frame.size)
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshButton.setImage(UIImage(named: "ic_refresh"), for:.normal)
        setUpUi()
        setUpFetchResultsController()
        if(dogs.isEmpty){
            fetchList()
        }
    }
    func setUpFetchResultsController(){
        let breedsFetchRequest = NSFetchRequest<CoreDataDog>(entityName: "CoreDataDog")
        breedsFetchRequest.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: breedsFetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            let count = try fetchedResultsController.managedObjectContext.count(for: fetchedResultsController.fetchRequest)
            for index in 0..<count{
                let dog = fetchedResultsController.object(at: IndexPath(row: index, section: 0))
                dogs.append(dog)
                self.collectionView.reloadData()
                self.setViewAfterAPICall()
            }
        } catch  {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    fileprivate func fetchList(){
        HomeController.Shared.fetchDogs(pageNum:"\(page)"){
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
        messageText.isHidden = false
        imageView.isHidden = false
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
         setViewsForApiCall()
         fetchList()
    }
    
    
    @IBAction func onRefreshClicked(_ sender: Any) {
        for dog in fetchedResultsController.fetchedObjects!{
            DataController.shared.viewContext.delete(dog)
            DataController.shared.saveContext()
        }
        setViewsForApiCall()
        page += 1
        fetchList()
    }
}
