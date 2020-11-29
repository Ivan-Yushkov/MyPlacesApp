//
//  RealmManager.swift
//  MyPlaces
//
//  Created by Иван Юшков on 29.11.2020.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func savePlace(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deletePlace(_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
    
}
