//
//  BreedListViewController+Delegates.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 27/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

extension BreedListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedcell")
        cell?.textLabel?.text = breeds[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedId = breeds[indexPath.row].id
        activityIndicator.startAnimating()
        fetchDogById(id: breedId)
    }
}
