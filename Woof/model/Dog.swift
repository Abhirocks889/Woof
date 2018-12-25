//
//  Dog.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//
//{
//"breeds": [
//{
//"id": 260,
//"name": "Wirehaired Pointing Griffon",
//"life_span": "12 - 14 years",
//"bred_for": "Gundog, \"swamp-tromping\", Flushing, pointing, and retrieving water fowl & game birds",
//"breed_group": "Sporting",
//"temperament": "Loyal, Gentle, Vigilant, Trainable, Proud",
//"weight": {
//"imperial": "45 - 70 lbs",
//"metric": "20 - 32 kgs"
//},
//"height": {
//"imperial": "20 - 24 inches at the withers",
//"metric": "51 - 61 cm at the withers"
//}
//}
//],
//"categories": [],
//"id": "Bkam2l9Vm",
//"url": "https://cdn2.thedogapi.com/images/Bkam2l9Vm_640.jpg"
//},

import Foundation

class Dog {
    var breed:[Breed] = []
    var id = ""
    var url = ""
}
