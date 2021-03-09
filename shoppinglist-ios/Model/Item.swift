//
//  Item.swift.swift
//  shoppinglist-ios
//
//  Created by NhutHuynh on 3/9/21.
//

import UIKit
import Foundation

class Item: Codable {
    
    var isChecked: Bool
    var name     : String
    
    init(name: String, isChecked: Bool = false) {
        
        self.name      = name
        self.isChecked = isChecked
    }
    
    func toggelCheck() -> Item {
        
        return Item(name: name, isChecked: !isChecked)
    }
    
    static func fake(_ count: Int) -> [Item] {
        
        var items = [Item]()
        
        for i in 0...count {
            
            let item = Item(name: "Item \(i)", isChecked: i % 2 == 0 )
            
            items.append(item)
        }
        return items
    }
}

extension Array where Element == Item {
    
    func save() {
    
        let data = try? PropertyListEncoder().encode(self)
      
        UserDefaults.standard.set(data, forKey: String(describing: Element.self))
        UserDefaults.standard.synchronize()
    }
    
    static func load() -> [Element] {
    
        if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data,
           let items = try? PropertyListDecoder().decode([Element].self, from: data) {

            return items
        }
        return []
    }
}
