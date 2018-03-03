//
//  BookDetailsViewController.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/3/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookTitleLbl: UILabel!
    @IBOutlet weak var bookAuthorsLbl: UILabel!
    @IBOutlet weak var bookPublishersLbl: UILabel!
    @IBOutlet weak var bookTagsLbl: UILabel!
    @IBOutlet weak var bookCheckoutLbl: UILabel!
    
    var selectedBook: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Even though we get complete Book details from selected row in table, we get the updated book from API in case book details
        // are modified from another source.
        self.getBookDetails()
    }

    @IBAction func onCheckOutClicked(_ sender: UIButton) {
        self.popCheckoutFormDialog()
    }
    
    @IBAction func onShareClicked(_ sender: Any) {
        let shareContent = "\(selectedBook.title!) by \(selectedBook.author!). Its a great Book to read!"
        let shareVC = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
        self.present(shareVC, animated: true, completion: {})
    }
    
    private func getBookDetails() -> Void {
        BooksAPIService.getBookWithId(bookURL: selectedBook.url) { (book) in
            self.selectedBook = book
            self.setBookDetails()
        }
    }
    
    private func setBookDetails() -> Void {
        self.bookTitleLbl.text = selectedBook.title
        self.bookAuthorsLbl.text = selectedBook.author
        self.bookPublishersLbl.text = selectedBook.publisher
        self.bookTagsLbl.text = selectedBook.categories
        self.bookCheckoutLbl.text = selectedBook.lastCheckedOutBy!.count > 0 ? "\(selectedBook.lastCheckedOutBy!) @ \(selectedBook.lastCheckedOut!)" : "-"
    }
    
    private func popCheckoutFormDialog() {
        let checkoutForm = UIAlertController(title: "Checkout Form",
                                      message: "Please enter your name:",
                                      preferredStyle: .alert)
        checkoutForm.addTextField { (nameTextField: UITextField) in
            nameTextField.placeholder = "FirstName LastName"
        }
        
        checkoutForm.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            if let name = checkoutForm.textFields?.first?.text {
                if name.count > 0 {
                    self.checkoutBook(by: name)
                }
            }
        }))
        
        checkoutForm.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(checkoutForm, animated: true, completion: nil)
    }
    
    private func checkoutBook(by name: String!) {
        let checkoutForm: Dictionary<String, String> = [
            "lastCheckedOutBy": name
        ]
        BooksAPIService.putCheckoutBook(checkoutForm, bookId: self.selectedBook.id) { (updatedBook) in
            if updatedBook != nil {
                self.selectedBook = updatedBook
                self.setBookDetails()
            } else {
                let alert = UIAlertController(title: "Error",
                                              message: "Error checking out, please try again",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
