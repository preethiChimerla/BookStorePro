//
//  BooksViewController+TableView.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/4/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import Foundation
import UIKit

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
                    self.getAllBooks()
                } else {
                    self.popAlert(title: "Error", message: "Problem deleting the book, please try again later")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "bookDetailsSegue") {
            let detailsViewController = segue.destination as? BookDetailsViewController
            detailsViewController?.selectedBook = self.selectedBook
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
