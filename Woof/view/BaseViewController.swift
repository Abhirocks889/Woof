//
//  BaseViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 03/01/19.
//  Copyright © 2019 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlerMessage(message:String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
