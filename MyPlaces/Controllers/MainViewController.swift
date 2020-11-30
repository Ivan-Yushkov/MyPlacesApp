//
//  TableViewController.swift
//  MyPlaces
//
//  Created by Иван Юшков on 26.11.2020.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sortingMethod = true
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reverseButton: UIBarButtonItem!
    
    fileprivate var places: Results<Place>!
    let identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        places = realm.objects(Place.self)
    }
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reversingSorting(_ sender: UIBarButtonItem) {
        sortingMethod.toggle()
        if sortingMethod {
            reverseButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: sortingMethod)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: sortingMethod)
        }
        tableView.reloadData()
    }
   
    
    //MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            let vc = segue.destination as! NewPlaceViewController
            vc.currentPlace = place
        }
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let place = places[indexPath.row]

        cell.nameLable.text = place.name
        cell.locationLable.text = place.location
        cell.typeLable.text = place.type
        cell.placeImageView.image = UIImage(data: place.imageData!)
            
        cell.placeImageView.clipsToBounds = true
        cell.placeImageView.layer.cornerRadius = cell.placeImageView.frame.size.height / 2

        return cell
    }
    

    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    //MARK: - Methods for editing rows
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let place = self?.places[indexPath.row] else { return }
            StorageManager.deletePlace(place)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    

//MARK: - Method for select row
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let place = places[indexPath.row]
//        performSegue(withIdentifier: "1111", sender: place)
//    }
  


    //MARK: - Cancel from new place view controller
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.saveAction()
        tableView.reloadData()
    }
}
