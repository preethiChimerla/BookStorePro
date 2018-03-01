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
    
    @IBOutlet weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.delegate = self
        booksTableView.dataSource = self
        let book1 = Book("My Life Story", "Preethi")
        let book2 = Book("Success Story", "Chimerla")
        bookList.append(book1)
        bookList.append(book2)
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

}

