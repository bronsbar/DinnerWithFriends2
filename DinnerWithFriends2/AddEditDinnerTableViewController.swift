//
//  AddEditDinnerTableViewController.swift
//  DinnerWithFriends
//
//  Created by Bart Bronselaer on 9/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit
import CoreData

class AddEditDinnerTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate //UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    // Mark: Properties
    var dinner = Dinners()
    let datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    
    // Mark: Outlets
    
    @IBOutlet weak var dinnerPictureLabel: UIImageView!
    @IBOutlet weak var dinnerDateLabel: UITextField!
    @IBOutlet weak var dinnerNameLabel: UITextField!
    @IBOutlet weak var dinnerFriendsLabel: UITextField!
    @IBOutlet weak var dinnerDescriptionLabel: UITextField!
    @IBOutlet weak var dinnerRatingLabel: UITextField!
    @IBOutlet weak var dinnerUrlLabel: UITextField!
    @IBOutlet weak var dinnerNotesLabel: UILabel!
    
    // save button outlet needed to enable or disable save button depending on all fields
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: Create delegates
        dinnerDateLabel.delegate = self
        dinnerNameLabel.delegate = self
        dinnerFriendsLabel.delegate = self
        dinnerDescriptionLabel.delegate = self
        dinnerRatingLabel.delegate = self
        dinnerUrlLabel.delegate = self
        
        tableView.delegate = self

        // Create DatePicker
        createDatePicker()
        
//        // PickerView for Friends
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        dinnerFriendsLabel.inputView = pickerView
        
        
        
        
        
        // Fill labels with properties of dinner object
        if let dinnerPictureData = dinner.picture as Data? {
            let dinnerPicture = UIImage(data: dinnerPictureData)
                dinnerPictureLabel.image = dinnerPicture
            } else {
                dinnerPictureLabel.image = UIImage(named: "No Picture")
            }
           // dinnerDateLabel.text = dinner.picture
            dinnerNameLabel.text = dinner.name!
//            if dinner.dinnerFriends == [] {
//                dinnerFriendsLabel.text = "no dinner Friends"
//            } else {
//                dinnerFriendsLabel.text = dinner.dinnerFriends[0]
//            }
//            dinnerDescriptionLabel.text = dinner.dinnerDescription
//            dinnerRatingLabel.text = String(describing: dinner.dinnerRating)
//            dinnerUrlLabel.text = dinner.dinnerUrl
//            dinnerNotesLabel.text = dinner.dinnerNotes
//        } else {
//            dinner = DinnerModel(dinnerPicture: nil, dinnerName: "", dinnerDescription: "", dinnerDate: "", dinnerFriends: [], dinnerRating: nil, dinnerUrl: nil, dinnerNotes: nil)
//
        
        updateSaveButtonState()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField, forEvent event: UIEvent) {

        updateSaveButtonState()
    }
    
    
    // Mark: Select or Edit the image


    // Mark: Setting and editing the date
    private func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button on toolbar
        let doneButtonforToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForDateLabel))
        toolbar.setItems([doneButtonforToolbar], animated: false)
        dinnerDateLabel.inputAccessoryView = toolbar
        dinnerDateLabel.inputView = datePicker

        //format datePicker for date
        datePicker.datePickerMode = .date
        datePicker.calendar = nil
    }

    @objc func donePressedForDateLabel () {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let dateString = dateFormatter.string(from: datePicker.date)
//
//        dinnerDateLabel.text = dateString
//        dinner.dinnerDate = dateString
//        self.view.endEditing(true)
    }
//    // Mark: UITextFieldDelegates methods
//
//    // resign textfield as first responder when Done is pressed
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
   // update the status of the save button if all fields (except url, notes, picture) received a value
    func updateSaveButtonState() {
        let dateText = dinnerDateLabel.text ?? ""
        let nameText = dinnerNameLabel.text ?? ""
        let friendsText = dinnerFriendsLabel.text ?? ""
        let descriptionText = dinnerDescriptionLabel.text ?? ""
        let ratingText = dinnerRatingLabel.text ?? ""
        saveButton.isEnabled = !dateText.isEmpty &&  !nameText.isEmpty && !friendsText.isEmpty && !descriptionText.isEmpty && !ratingText.isEmpty
    }
//
//    // delegate for PickerView
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return dinner.dinnerFriends.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return dinner.dinnerFriends[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        dinnerFriendsLabel.resignFirstResponder()
//    }
//
//    // Tableview delegates
//
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        print ("acces button tapped")
//        performSegue(withIdentifier: "segueFriends", sender: self)
//    }
//
//
//
//    // Mark: Segues
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // prepare is the Save button is pressed
//        if segue.identifier == "segueAddSave" {
//            dinner.dinnerDate = dinnerDateLabel.text ?? ""
//            dinner.dinnerName = dinnerNameLabel.text ?? ""
//           // dinner.dinnerFriends = nog uit te werken
//            dinner.dinnerDescription = dinnerDescriptionLabel.text ?? ""
//            dinner.dinnerRating = Int(dinnerRatingLabel.text!)
//            dinner.dinnerUrl = dinnerUrlLabel.text ?? ""
//            dinner.dinnerNotes = dinnerNotesLabel.text ?? ""
//        }
//        if segue.identifier == "seguePicture" {
//            let firstdestination = segue.destination as! UINavigationController
//            let destination = firstdestination.topViewController as! dinnerPictureViewController
//                destination.navigationItem.title = dinner.dinnerName
//            // pass the dinner poperties to dinnerPictureViewcontroller
//            destination.dinner = dinner
//        }
//        if segue.identifier == "segueNotes" {
//            let firstdestination = segue.destination as! UINavigationController
//            let destination = firstdestination.topViewController as! notesViewController
//            destination.navigationItem.title = "Notes"
//            // pass the notes poperties to notesViewcontroller
//            destination.dinnerNotes = dinner.dinnerNotes
//
//        }
//
//        if segue.identifier == "segueFriends" {
//            let firstdestination = segue.destination as!UINavigationController
//            let destination = firstdestination.topViewController as! FriendsTableViewController
//            destination.navigationItem.title = "Friends at the Dinner"
//            destination.dinnerFriends = dinner.dinnerFriends
//        }
//
//
//    }
//    @IBAction func unwindSegueFromPictureSelection(segue:UIStoryboardSegue) {
//
//        let sourceViewController = segue.source as! dinnerPictureViewController
//
//        if segue.identifier == "seguePictureDone" {
//            self.dinner.dinnerPicture = sourceViewController.dinner.dinnerPicture
//            self.dinnerPictureLabel.image = self.dinner.dinnerPicture
//        }
//        if segue.identifier == "seguePictureCancel" {
//           // do nothing
//        }
//
//    }
//    @IBAction func unwindSegueFromNotesViewController(segue: UIStoryboardSegue){
//        if segue.identifier == "segueNotesDone" {
//            let vc = segue.source as! notesViewController
//            self.dinner.dinnerNotes = vc.dinnerNotes
//            self.dinnerNotesLabel.text = self.dinner.dinnerNotes
//        }
//        if segue.identifier == "segueNotesCancel"{
//
//            // for the time being nothing done
//        }
//    }
//    @IBAction func unwindSegueFromFriendsViewController(segue: UIStoryboardSegue) {
//        print ("unwing from Friends viewcontroller")
//
//    }
}

