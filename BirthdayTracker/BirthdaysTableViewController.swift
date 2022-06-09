//
//  BirthdaysTableViewController.swift
//  BirthdaysTracker
//
//  Created by Zuleykha Pavlichenkova on 04.06.2022.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController {
    
    var birthdays = [Birthday]()
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        
        let sortDescriptor1 = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        do {
            birthdays = try context.fetch(fetchRequest)
        } catch let error {
            print("Cannot save because of error: \(error).")
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //returns number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of rows
        return birthdays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath) // should be called for the same name (String) as that was defined in the storyboard, otherwise it will crash
        let birthday = birthdays[indexPath.row]
        
        // Configure the cell...
        
        let firstName = birthday.firstName ?? ""
        let lastName = birthday.lastName ?? ""
        cell.textLabel?.text = firstName + " " + lastName
        
        if let date = birthday.birthDate as Date? {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.detailTextLabel?.text = " "
        }
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if birthdays.count > indexPath.row { //checking that birthdays count == rows count
            let birthday = birthdays[indexPath.row] // object from the birtdays array is assigned to the constant
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate // giving to add delegate the access to the context of the object
            let context = appDelegate.persistentContainer.viewContext
            context.delete(birthday) // object is being deleted from the contexts
            birthdays.remove(at: indexPath.row) // deleting the object from DB
            do {
                try context.save() // to save changes
            } catch let error {
                print("Cannot save because of error: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade) // deleting the row where the object was appearing earlier
        }
    }
}
