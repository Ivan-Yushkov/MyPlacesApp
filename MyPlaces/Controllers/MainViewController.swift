//
//  TableViewController.swift
//  MyPlaces
//
//  Created by Иван Юшков on 26.11.2020.
//

import UIKit

class MainViewController: UITableViewController {

   
    
    let places = Place.getPlaces()
    
    let identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let place = places[indexPath.row]
        
        cell.nameLable.text = place.name
        cell.locationLable.text = place.location
        cell.typeLable.text = place.type
        cell.placeImageView.image = UIImage(named: place.image)
        cell.placeImageView.clipsToBounds = true
        cell.placeImageView.layer.cornerRadius = cell.placeImageView.frame.size.height / 2

        return cell
    }
    

    //MARK: - Table View Delegate
  
    //MARK: - Cancel from new place view controller
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}
