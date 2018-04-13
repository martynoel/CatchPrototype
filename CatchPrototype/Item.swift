//
//  Item.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var dateAddedString: String
    var dateLastWornString: String
    
    init(name: String) {
        self.name = name
        
        let dateAdded = Date()
        let dateLastWorn = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        self.dateAddedString = dateFormatter.string(from: dateAdded)
        self.dateLastWornString = dateFormatter.string(from: dateLastWorn)
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        
        if random {
            
            let colors = ["White", "Pink", "Red", "Orange", "Yellow", "Green", "Aqua", "Blue", "Navy", "Light Purple", "Violet", "Gray", "Black", "Patterned"]
            let brands = ["Abercrombie", "Lilly Pulitzer", "H&M"]
            
            // Selects random color from colors array
            var randomIndex = arc4random_uniform(UInt32(colors.count))
            let randomColor = colors[Int(randomIndex)]
            
            // Selects random brand from brands array
            randomIndex = arc4random_uniform(UInt32(brands.count))
            let randomBrand = brands[Int(randomIndex)]
            
            // Creates random dress name from color and brand
            let randomName = "\(randomColor) \(randomBrand) dress"
            
//            let name = "Hello, my name is Mimi and I'm looking for a super long string of text. Haha hey."
            
            self.init(name: randomName)
        }
            
        else {
            self.init(name: "")
        }
    }
}
