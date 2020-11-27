//
//  TableViewController.swift
//  MyPlaces
//
//  Created by Иван Юшков on 26.11.2020.
//

import UIKit

class MainViewController: UITableViewController {

    let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    let identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let place = restaurantNames[indexPath.row]
        
        cell.nameLable.text = place
        cell.placeImageView.image = UIImage(named: place)
        cell.placeImageView.clipsToBounds = true
        cell.placeImageView.layer.cornerRadius = cell.placeImageView.frame.size.height / 2

        return cell
    }
    

    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
