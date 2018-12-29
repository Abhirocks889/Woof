//
//  BreedListViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 27/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var breeds:[Breeds] = []
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var filteredBreeds: [Breeds] = []
    var searchController = UISearchController(searchResultsController: nil)


    fileprivate func configureSearchBar() {
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchBreeds()
        configureSearchBar()
    }

    func fetchDogById(id:Int){
        BreedsController.Shared.getDogByBreed(breedId:id){
            (isSuccess,response,errorMessage) in
            self.activityIndicator.stopAnimating()
            if(isSuccess){
                if let dog = response {
                    let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailvc") as! DetailViewController
                    destinationViewController.dog = dog
                    self.navigationController?.pushViewController(destinationViewController, animated: true)
                }
            }else{
                //Handle failure case
            }
        }
        
    }
    fileprivate func fetchBreeds(){
        BreedsController.Shared.getBreeds{
            (isSuccess,response,errorMessage) in
            if(isSuccess){
                if let response = response{
                    self.breeds = response
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }else{
                //Handle failure case here
            }
        }
    }
}
