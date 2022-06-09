//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Zuleykha Pavlichenkova on 29.05.2022.
//

import UIKit
import CoreData

class AddBirthdayViewController: UIViewController {
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthDatePicker.maximumDate = Date()
    }
    
    @IBAction func saveTapped(_sender: UIBarButtonItem) {
        print("Save button is tapped.")
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthDate = birthDatePicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthDate as NSDate?
        newBirthday.birthdayId = UUID().uuidString
        
        if let uniqueId = newBirthday.birthdayId {
            print("birthdayId = \(uniqueId)")
        }
        
        do {
            try context.save()
        } catch let error {
            print("Cannot save because of error: \(error).")
        }
    }
    
    @IBAction func cancelTapped(_sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
