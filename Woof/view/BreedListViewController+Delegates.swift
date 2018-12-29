//
//  BreedListViewController+Delegates.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 27/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

extension BreedListViewController:UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedcell")
        let breed:Breeds
        if(isFiltering()){
            breed = filteredBreeds[indexPath.row]
        }else{
            breed = breeds[indexPath.row]
        }
        cell?.textLabel?.text = breed.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltering()){
            return filteredBreeds.count
        }
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedId:Int
        if(isFiltering()){
            breedId = filteredBreeds[indexPath.row].id
        }else{
            breedId = breeds[indexPath.row].id
        }
        activityIndicator.startAnimating()
        fetchDogById(id: breedId)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredBreeds = breeds.filter({
            (breeds:Breeds) -> Bool in
            return breeds.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        if let text = searchController.searchBar.text{
            return searchController.isActive && !(text.isEmpty)
        }
        return false
    }
}
