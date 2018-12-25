//
//  Breed.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
// "breeds": [
//{
//    "id": 260,
//    "name": "Wirehaired Pointing Griffon",
//    "life_span": "12 - 14 years",
//    "bred_for": "Gundog, \"swamp-tromping\", Flushing, pointing, and retrieving water fowl & game birds",
//    "breed_group": "Sporting",
//    "temperament": "Loyal, Gentle, Vigilant, Trainable, Proud",
//    "weight": {
//        "imperial": "45 - 70 lbs",
//        "metric": "20 - 32 kgs"
//    },
//    "height": {
//        "imperial": "20 - 24 inches at the withers",
//        "metric": "51 - 61 cm at the withers"
//    }
//}
//],

import Foundation
class Breed {
    var id = -1
    var name = ""
    var lifeSpan = ""
    var bredFor = ""
    var breedGroup = ""
    var temperament = ""
    var weight:Weight = Weight()
    var height:Height = Height()
}
