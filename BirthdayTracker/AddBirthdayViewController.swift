//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Zuleykha Pavlichenkova on 29.05.2022.
//

import UIKit

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
        let birthdayDate = birthDatePicker.date
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthDate: birthdayDate)
        print("There is a new BDay")
        print("Name: \(newBirthday.firstName)\nLastname: \(newBirthday.lastName)\nBDay: \(newBirthday.birthDate)")
    }
    
    @IBAction func cancelTapped(_sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

