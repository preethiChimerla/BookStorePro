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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getAllBooks()
    }
    
    func getAllBooks() {
        print("GET BOOKS")
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
        BooksAPIService.deleteAllBooks() { (isSuccess) in
            if isSuccess {
                self.popAlert(title: "Success", message: "Succesfuly deleted all books.")
                self.booksTableView.reloadData()
            } else {
                self.popAlert(title: "Error", message: "Problem deleting all books, try again!")
            }
        }
    }
    
    private func popAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookCell {
            let book = bookList[indexPath.row]
            cell.updateBookCell(with: book)
            return cell
        } else {
            return BookCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBook = bookList[indexPath.row]
        performSegue(withIdentifier: "bookDetailsSegue", sender: self)            
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookIdToDelete = bookList[indexPath.row].id!
            BooksAPIService.deleteBook(bookId: bookIdToDelete) { (isSuccess) in
                if isSuccess {
                    self.booksTableView.reloadData()
                } else {
                    self.popAlert(title: "Error", message: "Problem deleting the book, please try again later")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "bookDetailsSegue") {
            let detailsViewController = segue.destination as? BookDetailsViewController
            detailsViewController?.currentBook = self.selectedBook
        }
    }
}

