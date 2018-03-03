//
//  ViewController.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/3/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookPublisher: UITextField!
    @IBOutlet weak var bookCategories: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onNewBookSubmit(_ sender: UIButton) {
        
    }
    
    @IBAction func onDoneClick(_ sender: UIBarButtonItem) {
    
    }
}
