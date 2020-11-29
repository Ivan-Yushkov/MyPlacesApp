//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Иван Юшков on 28.11.2020.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    
    fileprivate var imageIsChanged = false
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var newPlaceImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    //MARK: - method for save new place
    @IBAction func saveAction() {
        
        
        var image: UIImage?
        if imageIsChanged {
            image = newPlaceImageView.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        guard let imageData = image?.pngData() else { return }
        let newPlace = Place(name: nameTextField.text!, location: locationTextField.text, type: typeTextField.text, imageData: imageData)
        StorageManager.savePlace(newPlace)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - method for observe editing name text field
    @objc func textFieldDidChanged() {
        if nameTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let alerSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alerSheet.addAction(camera)
            alerSheet.addAction(photo)
            alerSheet.addAction(cancel)
            present(alerSheet, animated: true, completion: nil)
        } else {
            view.endEditing(true)
        }
    }
}



//MARK: - Text field Delegate
extension NewPlaceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK: - Work with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        newPlaceImageView.image = info[.editedImage] as? UIImage
        newPlaceImageView.contentMode = .scaleAspectFill
        newPlaceImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
        imageIsChanged = true
    }
}
