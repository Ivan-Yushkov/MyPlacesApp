//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Иван Юшков on 28.11.2020.
//

import RealmSwift


class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
    
    convenience init(name: String, location: String?, type: String?, imageData: Data) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
