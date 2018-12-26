//
//  DetailViewController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var dog:Dog = Dog()
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
            guard let url = URL(string: self.dog.url) else {
                fatalError("Url not available")
            }
            guard let imageData = try?Data(contentsOf: url) else {
                fatalError("Could not form image")
            }
            guard let image = UIImage(data: imageData) else {
                fatalError("Could not form image from image data")
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.detailImageView.image = image
                let breed = self.dog.breed[0]
                self.nameTextView.text = breed.name
                var bredFor = breed.bredFor
                if(bredFor.isEmpty){
                    bredFor = "NA"
                }
                self.bredForTextView.text = bredFor
                var breedGroup = breed.breedGroup
                if(breedGroup.isEmpty){
                    breedGroup = "NA"
                }
                self.bredGroupTextView.text = breedGroup
                self.weightTextView.text = "\(breed.weight.imperial) / \(breed.weight.metric)"
                self.heightTextView.text = "\(breed.height.metric)"
                var temperment = breed.temperament
                if(temperment.isEmpty){
                    temperment = "NA"
                }
                self.tempermantTextView.text = temperment
                self.tempermantTextView.sizeToFit()
            }
        }
    }
}
