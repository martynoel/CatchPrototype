//
//  ItemStore.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

// Database for items
class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        // Remove item at certain index in "allItems" array
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    // Goes along with tableView(_:moveRowAt:to:) in ItemVC
    func moveItem(from oldIndex: Int, to newIndex: Int) {
        
        if oldIndex == newIndex {
            return
        }
        
        // Get the item being moved in order to reinsert it into the array
        let movedItem = allItems[oldIndex]
        
        // Remove and re-insert
        allItems.remove(at: oldIndex)
        allItems.insert(movedItem, at: newIndex)
    }
}
