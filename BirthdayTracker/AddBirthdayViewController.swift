//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Zuleykha Pavlichenkova on 29.05.2022.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    
    func addBirthdayViewController(_addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}

class AddBirthdayViewController: UIViewController {
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthDatePicker: UIDatePicker!
    
    // to remind to TableViewController: Birthdays that new birthday was added
    var delegate: AddBirthdayViewControllerDelegate?
    
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
        
        // after new Birthday was created, new Birthday is passed to the addBirthdayViewController
        delegate?.addBirthdayViewController(_addBirthdayViewController: self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
//
//        print("There is a new BDay")
//        print("Name: \(newBirthday.firstName)\nLastname: \(newBirthday.lastName)\nBDay: \(newBirthday.birthDate)")
    }
    
    @IBAction func cancelTapped(_sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

