//
//  ContactTableViewController.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    // MARK: Properties
    
    var contacts = [Contact]()
    var name = ""
    var phone = ""
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleContacts()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ContactTableViewCell"
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.usernameLabel.text = contact.username
        cell.phoneLabel.text = contact.phone
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get selected cell.
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! ContactTableViewCell
        
        // Get selected cell info.
        name = currentCell.nameLabel.text!
        username = currentCell.usernameLabel.text!
        phone = currentCell.phoneLabel.text!
        
        // Nav to journey view controller
        self.performSegue(withIdentifier: "selectContact", sender: self)
    
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
     
     @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
     }
     
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass contact to injourney view controller
        if segue.identifier == "selectContact" {
            let nextController = segue.destination as! JourneyViewController
            nextController.name = name
            nextController.username = username
            nextController.phone = phone
        }
    }
 

    // MARK: Private Methods
    
    private func loadSampleContacts(){
        
        guard let contact1 = Contact(name: "Jane", username: "jane111", phone: "0450123456") else {
            fatalError("Unable to instantiate contact1")
        }
        
        guard let contact2 = Contact(name: "John", username: "john", phone: "0450111111") else {
            fatalError("Unable to instantiate contact2")
        }
        
        guard let contact3 = Contact(name: "Jerry", username: "jjj", phone: "0450222222") else {
            fatalError("Unable to instantiate contact3")
        }
        
        contacts += [contact1, contact2, contact3]
        
    }

}
