//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Иван Юшков on 28.11.2020.
//

import Foundation


struct Place {
    
    let name: String
    let location: String
    let type: String
    let image: String
    
    
    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    
    static func getPlaces() -> [Place] {
        var places = [Place]()
        
        for value in restaurantNames {
            let place = Place(name: value, location: "", type: "", image: value)
            places.append(place)
        }
        
        return places
    }
}
