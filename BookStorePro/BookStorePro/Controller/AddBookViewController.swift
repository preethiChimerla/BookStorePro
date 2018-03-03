//
//  ViewController.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/3/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    @IBOutlet weak var bookTitleLbl: UITextField!
    @IBOutlet weak var bookAuthorLbl: UITextField!
    @IBOutlet weak var bookPublisherLbl: UITextField!
    @IBOutlet weak var bookCategoriesLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onNewBookSubmit(_ sender: UIButton) {
        if self.validateForm() {
            let newBook: Dictionary<String, String> = [
                "title": bookTitleLbl.text!,
                "author": bookAuthorLbl.text!,
                "publisher": bookPublisherLbl.text!,
                "categories": bookCategoriesLbl.text!
            ]
            BooksAPIService.postNewBook(newBook) { (isSuccess) in
                if !isSuccess {
                    self.popAlert(title: "Error", message: "Unable to create new Book, please try again!")
                } else {
                    self.popAlert(title: "Success", message: "Successfuly create a new book")
                }
            }
        } else {
            self.popAlert(title: "Error", message: "Form fields cannot be empty")
        }
    }
    
    @IBAction func onDoneClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func popAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            self.clearFormFields()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func validateForm() -> Bool {
        if(self.bookAuthorLbl.text == "" ||
            self.bookTitleLbl.text == "" ||
            self.bookCategoriesLbl.text == "" ||
            self.bookPublisherLbl.text == "") {
            return false
        }
        return true
        
    }
    
    private func clearFormFields() -> Void {
        self.bookAuthorLbl.text = ""
        self.bookTitleLbl.text = ""
        self.bookCategoriesLbl.text = ""
        self.bookPublisherLbl.text = ""
    }
}
