//
//  DetailViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    var dog:CoreDataDog = CoreDataDog()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameTextView: UILabel!
    @IBOutlet weak var ageTextView: UILabel!
    @IBOutlet weak var bredForTextView: UILabel!
    @IBOutlet weak var bredGroupTextView: UILabel!
    @IBOutlet weak var weightTextView: UILabel!
    @IBOutlet weak var heightTextView: UILabel!
    
    @IBOutlet weak var tempermantTextView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            guard let image = UIImage(data:self.dog.image!) else {
                fatalError("Could not form image from image data")
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.detailImageView.image = image
                if let breed = self.dog.breeds{
                    self.nameTextView.text = breed.name
                    var bredFor = breed.bredfor
                    if(bredFor.isEmpty){
                        bredFor = "NA"
                    }
                    self.bredForTextView.text = bredFor
                    var breedGroup = breed.breedgroup
                    if(breedGroup.isEmpty){
                        breedGroup = "NA"
                    }
                    self.bredGroupTextView.text = breedGroup
                    self.weightTextView.text = "\(breed.weight.imperial) / \(breed.weight.metric)"
                    self.heightTextView.text = "\(breed.height.metric)"
                    var temperment = breed.tempermant
                    if(temperment.isEmpty){
                        temperment = "NA"
                    }
                    self.tempermantTextView.text = temperment
                    self.tempermantTextView.sizeToFit()
                }
               
            }
        }
    }
}
