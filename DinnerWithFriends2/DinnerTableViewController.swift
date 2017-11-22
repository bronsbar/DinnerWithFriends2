//
//  DinnerTableViewController.swift
//  DinnerWithFriends
//
//  Created by Bart Bronselaer on 7/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class DinnerTableViewController: UITableViewController {
    
    var dinners: [DinnerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add observers application resign active and application will terminate
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(DinnerTableViewController.applicationWillResignActive(notification:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
        
         NotificationCenter.default.addObserver(self, selector: #selector(DinnerTableViewController.applicationWillTerminate(notification:)), name: NSNotification.Name.UIApplicationWillTerminate, object: app)
        
        // load sample dinners
        
        dinners = DinnerTableViewController.loadSampleDinners()
  /*
        // check if there is a file available
        if let dinnersAvailable = DinnerModel.loadDinners() {
            dinners = dinnersAvailable
        } else {
           dinners = DinnerTableViewController.loadSampleDinners()
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

         //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
 */
     } // end of viewDidLoad
 
         
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of Sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows per section
        if section == 0 {
            return dinners.count
        } else {
            return 0}
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // dequeu cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewTableCell", for: indexPath) as! DinnerTableViewCell

        // fetch model object to display
        let dinner = dinners[indexPath.row]
        
        // if there is no picture, assign "No Picture" image to dinnerPicture
        if dinner.dinnerPicture == nil {
            dinner.dinnerPicture = UIImage(named: "No Picture")
        }
        // configure cell
        cell.update(with: dinner)
        
        cell.showsReorderControl = true
        // return cell
        return cell
    }

  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dinner = dinners[indexPath.row]
        print (dinner.dinnerFriends)
    }
    */
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dinners.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedDinner = dinners.remove(at: fromIndexPath.row)
        dinners.insert(movedDinner, at: to.row)
        tableView.reloadData()
    }
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditDinnerSegue" {
            let indexPath = tableView.indexPathForSelectedRow!
            let dinner = dinners[indexPath.row]
            let addEditNavigationController = segue.destination as! UINavigationController
            let addEditTableViewController = addEditNavigationController.topViewController as! AddEditDinnerTableViewController
            addEditTableViewController.dinner = dinner
        }
    }
    
    
    @IBAction func unwindToDinnerTableView(segue: UIStoryboardSegue) {
        
        let sourceViewController = segue.source as! AddEditDinnerTableViewController
        if segue.identifier == "segueAddSave"{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                dinners[selectedIndexPath.row] = sourceViewController.dinner
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: dinners.count, section: 0)
                dinners.append(sourceViewController.dinner)
                tableView.insertRows(at: [newIndexPath], with: .middle)
                
            }
            DinnerModel.saveDinners(dinners)
        }
        if segue.identifier == "segueAddCancel" {
            // do nothing
        }
    }
 */
    
    static func loadSampleDinners() -> [DinnerModel] {
        return [DinnerModel(dinnerPicture: UIImage(named:"pizza.png"), dinnerName:"Patatten met ambras", dinnerDescription:"", dinnerDate: "11-11-2017", dinnerFriends: ["bart","Koen"], dinnerRating :5, dinnerUrl: nil, dinnerNotes:"dit was lekker"), DinnerModel(dinnerPicture: nil, dinnerName:"rode kool met worsten", dinnerDescription:"lekkere rode kool met zwarte en witte pensen", dinnerDate: "06-10-1967", dinnerFriends: ["bart","sofie"], dinnerRating :3, dinnerUrl: nil, dinnerNotes:"ne klassieker uit den ouden tijd")]

    }
    
    // Save when application will resign active and application will terminate
    @objc func applicationWillResignActive(notification: NSNotification) {
        
       // DinnerModel.saveDinners(dinners)
    }
    @objc func applicationWillTerminate(notification:NSNotification) {
       // DinnerModel.saveDinners(dinners)
    }
}

 
