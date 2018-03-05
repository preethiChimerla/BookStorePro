//
//  ViewController.swift
//  BookStorePro
//
//  Created by preethi Reddy on 2/28/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController{
    
    var bookList: [Book] = []
    var selectedBook: Book?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getAllBooks()
    }
    
    @IBAction func onAddNewBookClick(_ sender: UIBarButtonItem) {
        if let addBookVC = self.storyBoard.instantiateViewController(withIdentifier: "AddBookVC") as? AddBookViewController {
            present(addBookVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func onDeleteAllBooksClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Confirmation",
                                      message: "Are you sure you want to delete all Books?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            self.deleteAllBooks()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteAllBooks() -> Void {
        BooksAPIService.deleteAllBooks() {
            self.popAlert(title: "Success", message: "Succesfuly deleted all books.")
            self.getAllBooks()
        }
    }
    
    private func popAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getAllBooks() {
        BooksAPIService.getAllBooks() { (books) in
            if books == nil {
                let booksErrorAlert = UIAlertController(title: "API failed to respond",
                                                        message: "Unable to retrieve books. Please try again later.",
                                                        preferredStyle: .alert)
                self.present(booksErrorAlert, animated: true, completion: nil)
            } else {
                self.bookList = books!
                self.booksTableView.reloadData()
            }
        }
    }
}



